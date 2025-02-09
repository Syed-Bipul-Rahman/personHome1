import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health_app/helpers/error_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/route.dart';
import '../../models/care_giver_notification_model.dart';
import '../../models/booking/single_booking_model.dart';
import '../../service/api_checker.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';
import '../../utils/app_strings.dart';

class JobListController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  var notificationList = <CaregiverNotificationJobListModel>[].obs;
  var isLoading = true.obs;

  // getJobListNotification() async {
  //   notificationList.clear();
  //   try {
  //     isLoading(true);
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final String? accessToken = prefs.getString(AppStrings.accessToken);
  //
  //     if (accessToken == null) {
  //       Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
  //       return;
  //     }
  //
  //     var headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $accessToken'
  //     };
  //
  //     final response = await ApiClient.getData(
  //         ApiConstants.myNotificationEndPoint,
  //         headers: headers);
  //
  //     if (response.statusCode == 200) {
  //       var myNotifications =
  //           response.body['data']['attributes']['notifications'];
  //
  //       print('Response bookings: $myNotifications');
  //
  //       var notifications = List<CaregiverNotificationJobListModel>.from(
  //           myNotifications
  //               .map((x) => CaregiverNotificationJobListModel.fromJson(x)));
  //
  //       notificationList.assignAll(notifications);
  //
  //
  //      } else {
  //       var message = response.body['message'] ?? "Unknown error";
  //       Get.snackbar(AppStrings.errorTextSpecial.tr, message,
  //           backgroundColor: Colors.red, colorText: Colors.white);
  //     }
  //   } catch (e) {
  //     print('Error fetching bookings: for ===>  $e');
  //     Get.snackbar(AppStrings.errorTextSpecial.tr, e.toString(),
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  getJobListNotification() async {
    notificationList.clear();
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
          ApiConstants.myNotificationEndPoint,
          headers: headers);

      if (response.statusCode == 200) {
        var myNotifications =
        response.body['data']['attributes']['notifications'];

        print('Response bookings: $myNotifications');

        // Filter notifications to include only those with a `bookingId`
        var filteredNotifications = myNotifications.where((notification) =>
        notification['bookingId'] != null).toList();

        var notifications = List<CaregiverNotificationJobListModel>.from(
            filteredNotifications
                .map((x) => CaregiverNotificationJobListModel.fromJson(x)));

        notificationList.assignAll(notifications);

      } else {
        var message = response.body['message'] ?? "Unknown error";
        Get.snackbar(AppStrings.errorTextSpecial.tr, message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('Error fetching bookings: for ===>  $e');
      Get.snackbar(AppStrings.errorTextSpecial.tr, e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  //================================== Single Notification ==================================

  var notificationId = ''.obs;

  var isSingleNotificationLoading = true.obs;
  var singleBookingDetails = SingleBookingModel().obs;

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
            SingleBookingModel.fromJson(myNotifications);
      } else {
        var message = response.body['message'] ?? "Unknown error";
        Get.snackbar(AppStrings.errorTextSpecial.tr, message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e, stackTrace) {
      String errorDetails = ErrorHelper.getErrorDetails(e, stackTrace);
      print('Booking details error : $errorDetails');
      Get.snackbar(AppStrings.errorTextSpecial.tr, errorDetails,
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isSingleNotificationLoading(false);
    }
  }

  //================================== Accept Booking ==================================
  var acceptBookingLoading = false.obs;

  acceptBooking() async {
    acceptBookingLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var response = await ApiClient.postDataOptionalBody(
        '${ApiConstants.acceptBookingEndPoint}/${singleBookingDetails.value.bookingId!.id}',
        headers: headers);

    print("===============>>Api response : ${response.statusCode}");

    if (response.statusCode == 200) {
      print("===============>>Api response : ${response.body}");
      Get.toNamed(AppRoutes.careGiverHomeScreen);
      Get.snackbar("Success",
          response.body['message'] ?? "Booking accepted successfully");
 
    } else if (response.statusCode == 409) {
      Get.snackbar(
          AppStrings.errorTextSpecial.tr, response.body['message'] ?? "Booking already accepted");
    } else if (response.statusCode == 400) {
      var message = response.body['message'];
      Get.toNamed(AppRoutes.careGiverHomeScreen);
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    } else {
      ApiChecker.checkApi(response);
      var message = response.body['message'];
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    }
    acceptBookingLoading.value = false;
  }

  //================================== Cancel Booking ==================================
  var cancelBookingLoading = false.obs;

  cancelBooking() async {
    cancelBookingLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var response = await ApiClient.postDataOptionalBody(
        '${ApiConstants.cancelBookingEndPoint}/${singleBookingDetails.value.bookingId!.id}',
        headers: headers);

    print("===============>>Api response : ${response.statusCode}");

    if (response.statusCode == 200) {
      print("===============>>Api response : ${response.body}");
      Get.snackbar("Success",
          response.body['message'] ?? "Booking accepted successfully");

      Get.back();
    } else if (response.statusCode == 409) {
      Get.snackbar(
          AppStrings.errorTextSpecial.tr, AppStrings.someThingWrong.tr);
    } else if (response.statusCode == 400) {
      var message = response.body['message'];
      Get.back();
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    } else {
      ApiChecker.checkApi(response);
      var message = response.body['message'];
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    }
    cancelBookingLoading.value = false;
  }
}
