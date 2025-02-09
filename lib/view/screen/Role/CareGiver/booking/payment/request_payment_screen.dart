import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health_app/view/screen/Role/CareGiver/booking/payment/payment_info_card.dart';

class RequestPaymentScreen extends StatefulWidget {
  const RequestPaymentScreen({super.key});

  @override
  State<RequestPaymentScreen> createState() => _RequestPaymentScreenState();
}

class _RequestPaymentScreenState extends State<RequestPaymentScreen> {
  var hourlyRate = 0;

  @override
  void initState() {
    hourlyRate = int.parse(Get.parameters['hourlyRate']!);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Request Payment'),
      ),
      body: PaymentInfoCard(
        rate: double.parse(hourlyRate.toString()),
      ),
    );
  }
}
