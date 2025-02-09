import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health_app/Stripe%20Payment/payment_notification_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_strings.dart';

class PaymentNotificationDetailsController extends GetxController {
  var isLoading = false.obs;
  var paymentNotificationDetails = PaymentNotificationModel().obs;

  getSingleNotification(String notificationId) async {
    try {
      isLoading(true);
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
          '${ApiConstants.singleNotificationEndPoint}/${notificationId}',
          headers: headers);
      if (response.statusCode == 200) {
        var myNotifications = response.body['data']['attributes'];
        print('Response payment Details notification: $myNotifications');

        paymentNotificationDetails.value =
            PaymentNotificationModel.fromJson(myNotifications);
        print("====================>>SUCCESSFULLY FETCHED NOTIFICATION DETAILS<<====================");
        print("====================>>${paymentNotificationDetails.value.bookingId!.hourRate}<<====================");

        isLoading(false);
      } else {
        var message = response.body['message'] ?? "Unknown error";
        Get.snackbar(AppStrings.errorTextSpecial.tr, message,
            backgroundColor: Colors.red, colorText: Colors.white);
        isLoading(false);
      }
    } catch (e) {
      print('Error fetching notification: $e');
      Get.snackbar(AppStrings.errorTextSpecial.tr, '$e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }
}
