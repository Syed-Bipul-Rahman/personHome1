import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_health_app/view/base/custom_page_loading.dart';

import '../../../../../Stripe Payment/payment_notification_details_controller.dart';
import '../../CareGiver/booking/payment/payment_info_card.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final PaymentNotificationDetailsController _paymentNotificationDetailsController =
  Get.put(PaymentNotificationDetailsController());

  @override
  void initState() {
    super.initState();
    final notificationId = Get.parameters['notificationId']!;
    print("Payment notification id: $notificationId");
    _paymentNotificationDetailsController.getSingleNotification(notificationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (_paymentNotificationDetailsController.isLoading.value) {
          return const Center(child: CustomPageLoading());
        } else if (_paymentNotificationDetailsController.paymentNotificationDetails.value == null) {
          return const Center(child: Text("No payment details available."));
        } else {
          final booking = _paymentNotificationDetailsController.paymentNotificationDetails.value.bookingId;
          if (booking == null) {
            return const Center(child: Text("Booking details not found."));
          }

          final hourlyRate = booking.hourRate ?? 0;
          final workTime = booking.workTime ?? 0;
          final totalMoneyToPaid = booking.totalAmount ?? 0;
          final bookingId = booking.id ?? '';

          return PaymentInfoCard(
            bookingId: bookingId,
            rate: hourlyRate.toDouble(),
            workTime: workTime.toDouble(),
            totalMoneyToPaid: totalMoneyToPaid.toDouble(),
            screen: 'user',
          );
        }
      }),
    );
  }
}