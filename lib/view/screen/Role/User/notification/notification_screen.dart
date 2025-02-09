import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/notification/notification_controller.dart';
import '../../../../../models/notification/notification_model.dart';
import '../../../../base/custom_page_loading.dart';
import 'notification_tile.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController _notificationController =
      Get.put(NotificationController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _notificationController.fetchNotificationList();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //=============================> AppBar Section <=======================
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      //=============================> Body Section <=========================
      body: Obx(() {
        if (_notificationController.isNotificationListLoading.value) {
          return CustomPageLoading();
        } else if (_notificationController.notificationList.isEmpty) {
          return Center(
            child: Text("No Notification Found"),
          );
        } else {
          return ListView.builder(
            itemCount: _notificationController.notificationList.length,
            itemBuilder: (context, index) {
              return NotificationTile(
                  notification:
                      _notificationController.notificationList[index]);
            },
          );
        }
      }),
    );
  }
}
