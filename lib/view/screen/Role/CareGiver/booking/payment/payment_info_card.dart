import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:home_health_app/Stripe%20Payment/payment_controller.dart';
import 'package:home_health_app/controller/work_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../Stripe Payment/keys.dart';
import '../../../../../../Utils/app_constants.dart';
import 'package:http/http.dart' as http;

class PaymentInfoCard extends StatefulWidget {
  final double rate;
  final screen;
  final double? totalMoneyToPaid;
  final double? workTime;
  final String? bookingId;

  const PaymentInfoCard({
    Key? key,
    required this.rate,
    this.totalMoneyToPaid,
    this.workTime,
    this.screen,
    this.bookingId,
  }) : super(key: key);

  @override
  State<PaymentInfoCard> createState() => _PaymentInfoCardState();
}

class _PaymentInfoCardState extends State<PaymentInfoCard> {
  String workTime = "0.0";
  String totalMoneyToPaid = "0.0";

  WorkController _workController = Get.put(WorkController());
  PaymentController _paymentController = Get.put(PaymentController());

  @override
  void initState() {
    super.initState();
    if (widget.workTime != null && widget.totalMoneyToPaid != null) {
      // If parameters are passed, use them directly
      setState(() {
        workTime = widget.workTime!.toStringAsFixed(2);
        totalMoneyToPaid = widget.totalMoneyToPaid!.toStringAsFixed(2);
      });
    } else {
      // Otherwise, calculate workTime and totalMoneyToPaid
      _updateWorkTime();
    }
  }

  Future<void> _updateWorkTime() async {
    double hours = await getTotalWorkTime();
    setState(() {
      workTime = hours.toStringAsFixed(2);
      // Only calculate totalMoneyToPaid if it was not passed as a parameter
      if (widget.totalMoneyToPaid == null) {
        totalMoneyToPaid = (hours * widget.rate).toStringAsFixed(2);
      }
      _workController.workTime.value = hours.toInt();
    });
  }

  Future<double> getTotalWorkTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? savedStartTime = prefs.getInt(AppConstants.startTimeKey);

    if (savedStartTime == null) {
      return 0;
    }

    final DateTime now = DateTime.now();
    final DateTime startTime =
    DateTime.fromMillisecondsSinceEpoch(savedStartTime);
    final Duration difference = now.difference(startTime);

    return difference.inMinutes / 60.0;
  }

  Widget buildInfoRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: const Color(0xFF4A148C),
          ),
        ),
      ],
    );
  }

  Map<String, dynamic>? internetPaymentData;

  showPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((val) {
        // Capture the transaction ID from the payment data
        String? transactionId = internetPaymentData?["id"];

        if (transactionId != null) {
          // Send the transaction ID to the server
          _paymentController.sendTransactionIdToServer(transactionId, widget.bookingId!);
        }

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

  paymentSheetInitialization(amountToBeCharge, currency) async {
    try {
      internetPaymentData =
      await makeInternetForPayment(amountToBeCharge, currency);

      if (internetPaymentData != null) {
        await Stripe.instance
            .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            allowsDelayedPaymentMethods: true,
            paymentIntentClientSecret: internetPaymentData!["client_secret"],
            style: ThemeMode.dark,
            merchantDisplayName: "Home Health Care",
          ),
        )
            .then((val) {
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
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Work time row
          buildInfoRow(
            'Total work time',
            '$workTime h',
          ),
          const SizedBox(height: 16),

          // Rate row
          buildInfoRow(
            'Rate',
            'USD ${widget.rate.toStringAsFixed(0)}/h',
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: Colors.grey,
          ),
          // Total row
          buildInfoRow(
            'Total',
            'USD $totalMoneyToPaid',
            isTotal: true,
          ),
          const SizedBox(height: 24),

          // Payment Request button
          widget.screen == 'user'
              ? SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                paymentSheetInitialization(
                  widget.totalMoneyToPaid?.round().toString(),
                  "USD",
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A148C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Pay',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
              :
          // Pay button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                double workTimeDouble = double.parse(workTime);
                _workController.sendPaymentRequest(workTime: workTimeDouble);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A148C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Payment Request',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}