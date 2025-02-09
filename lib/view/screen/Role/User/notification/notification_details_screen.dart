import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health_app/controller/notification/notification_controller.dart';
import 'package:home_health_app/view/base/custom_page_loading.dart';

class UserNotificationDetailsScreen extends StatefulWidget {
  const UserNotificationDetailsScreen({super.key});

  @override
  State<UserNotificationDetailsScreen> createState() =>
      _UserNotificationDetailsScreenState();
}

class _UserNotificationDetailsScreenState
    extends State<UserNotificationDetailsScreen> {
  final NotificationController _notificationController =
      NotificationController();

  @override
  void initState() {
    _notificationController.notificationId.value =
        Get.parameters['notificationId']!;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _notificationController.getSingleNotification();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Notification Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (_notificationController.isSingleNotificationLoading.value) {
          return const Center(
            child: CustomPageLoading(),
          );
        } else {
          final details =
              _notificationController.singleBookingDetails.value.bookingDetails;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  details?.description ?? "Description not found",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
