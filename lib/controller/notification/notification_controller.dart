import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health_app/models/notification/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/notification/notification_details.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';
import '../../utils/app_strings.dart';

class NotificationController extends GetxController {
  var isNotificationListLoading = false.obs;
  List<NotificationModel> notificationList = <NotificationModel>[].obs;

  fetchNotificationList() async {
    isNotificationListLoading.value = true;

    if (notificationList.isNotEmpty) {
      notificationList.clear();
    }

    try {
      isNotificationListLoading(true);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(AppStrings.accessToken);

      if (accessToken == null) {
        Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
        return;
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };

      final response = await ApiClient.getData(
          ApiConstants.notificationEndPoint,
          headers: headers);

      if (response.statusCode == 200) {
        // var myCarBookingResponse = response.body['data']['attributes'];

        // myBookingDetails.value = BookingDetails.fromJson(myCarBookingResponse);

        // notificationList = NotificationModel.fromJson(response.body['data']['attributes']['notifications']);

        notificationList.assignAll(List<NotificationModel>.from(response
            .body['data']['attributes']['notifications']
            .map((x) => NotificationModel.fromJson(x))));

        print(
            'NOtification List Length is  =========> : ${notificationList.length}');
        // print('Single booking =========> : $myCarBookingResponse');
        // isNotificationListLoading(false);
      } else {
        var message = response.body['message'] ?? "Unknown error";
        Get.snackbar(AppStrings.errorTextSpecial.tr, message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('Error fetching bookings: $e');
      Get.snackbar(AppStrings.errorTextSpecial.tr, '$e.',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isNotificationListLoading(false);
    }
  }

  //======================================== Notification Details====================================
  var notificationId = ''.obs;
  Rx<UserNotificationDetailsModel> singleBookingDetails =
      UserNotificationDetailsModel().obs;

var isSingleNotificationLoading = false.obs;
  getSingleNotification() async {
    notificationList.clear();
    try {
      isSingleNotificationLoading(true);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(AppStrings.accessToken);

      if (accessToken == null) {
        Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
        return;
      }
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      final response = await ApiClient.getData(
          '${ApiConstants.singleNotificationEndPoint}/${notificationId.value}',
          headers: headers);
      if (response.statusCode == 200) {
        var myNotifications = response.body['data']['attributes'];
        print('Response bookings: $myNotifications');
        singleBookingDetails.value =
            UserNotificationDetailsModel.fromJson(myNotifications);
      } else {
        var message = response.body['message'] ?? "Unknown error";
        Get.snackbar(AppStrings.errorTextSpecial.tr, message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('joy bangla=========>: $e');
      Get.snackbar(AppStrings.errorTextSpecial.tr, '$e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isSingleNotificationLoading(false);
    }
  }



}
