import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_constants.dart';
import '../../../../../utils/app_strings.dart';
import 'booking_details_model.dart';

class SingleBookingController extends GetxController{

  var isSingleBookingLoading = true.obs;

  var bookingId = ''.obs;

  var isSingleNotificationLoading = true.obs;
  var singleBookingDetails = BookingDetailsModel().obs;

  // getSingleBooking() async {
  //   try {
  //     isSingleNotificationLoading(true);
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final String? accessToken = prefs.getString(AppStrings.accessToken);
  //
  //     if (accessToken == null) {
  //       Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
  //       return;
  //     }
  //     var headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $accessToken'
  //     };
  //     final response = await ApiClient.getData(
  //         '${ApiConstants.singleBookingEndPoint}/${bookingId.value}',
  //         headers: headers);
  //     if (response.statusCode == 200) {
  //
  //       var singleBookings = response.body['data']['attributes'];
  //       print('Response bookings: $singleBookings');
  //
  //       singleBookingDetails.value = BookingDetailsModel.fromJson(singleBookings);
  //       // singleBookingDetails.value = SingleBookingModel.fromJson(myNotifications);
  //     } else {
  //       var message = response.body['message'] ?? "Unknown error";
  //       Get.snackbar(AppStrings.errorTextSpecial.tr, message,
  //           backgroundColor: Colors.red, colorText: Colors.white);
  //     }
  //   } catch (e) {
  //     print('Error fetching bookings: $e');
  //     Get.snackbar(AppStrings.errorTextSpecial.tr, '$e',
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   } finally {
  //     isSingleNotificationLoading(false);
  //   }
  // }


  getSingleBooking() async {
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
        '${ApiConstants.singleBookingEndPoint}/${bookingId.value}',
        headers: headers,
      );

      if (response.statusCode == 200) {
        var singleBookings = response.body;
        print('API Response: ${response.body}');
        print('Parsed Booking Details: ${singleBookings}');

        Logger logger = Logger();
        logger.i('API Response: ${response.body}');
        logger.i('Parsed Booking Details: $singleBookings');

        singleBookingDetails.value = BookingDetailsModel.fromJson(singleBookings['data']['attributes']);

        logger.i('Single Booking ......................>>>>>>>>: ${singleBookingDetails.value}');
        logger.i('Single Booking description: ${singleBookingDetails.value.description}');

      } else {
        var message = response.body['message'] ?? "Unknown error";
        Get.snackbar(AppStrings.errorTextSpecial.tr, message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('Error fetching bookings: $e');
      Get.snackbar(AppStrings.errorTextSpecial.tr, '$e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isSingleNotificationLoading(false);
    }
  }

}