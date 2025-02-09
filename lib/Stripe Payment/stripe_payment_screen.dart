import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'keys.dart';

class StripePaymentScreen extends StatefulWidget {
  const StripePaymentScreen({super.key});

  @override
  State<StripePaymentScreen> createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  double amount = 500;
  Map<String, dynamic>? internetPaymentData;

  // Show Payment Sheet
  showPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((val) {
        internetPaymentData = null;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment Successful!")),
        );
      }).onError((error, stackTrace) {
        print(error);
      });
    } on StripeException catch (error) {
      print("Stripe Error: $error");
      showDialog(
        context: context,
        builder: (c) => AlertDialog(
          title: Text("Payment Error"),
          content: Text(error.toString()),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () => Navigator.pop(c),
            ),
          ],
        ),
      );
    } catch (error) {
      print("General Error: $error");
    }
  }


  // Make Internet Payment Request
  makeInternetForPayment(amountToBeCharge, currency) async {
    try {
      Map<String, dynamic>? paymentInfo = {
        'amount': (int.parse(amountToBeCharge) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var responseFromStripe = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: paymentInfo,
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      print('Response from Stripe: ${responseFromStripe.body}');
      return jsonDecode(responseFromStripe.body);
    } catch (error) {
      print("Error: $error");
    }
  }

  // Initialize Payment Sheet
  paymentSheetInitialization(amountToBeCharge, currency) async {
    try {
      internetPaymentData = await makeInternetForPayment(amountToBeCharge, currency);

      if (internetPaymentData != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            allowsDelayedPaymentMethods: true,
            paymentIntentClientSecret: internetPaymentData!["client_secret"],
            style: ThemeMode.dark,
            merchantDisplayName: "Mahafujer Rahman",
          ),
        ).then((val) {
          print("Payment sheet initialized: $val");
        });

        showPaymentSheet();
      } else {
        print("Failed to get payment data.");
      }
    } catch (error) {
      print("Error during payment sheet initialization: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextButton(
              onPressed: () {
                paymentSheetInitialization(
                  amount.round().toString(),
                  "USD",
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Pay Now \$${amount.toString()}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}