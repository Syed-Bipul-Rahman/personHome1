import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health_app/models/booking/complete_booking_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/booking/accepted_booking_list_model.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';
import '../../utils/app_strings.dart';

class MyBookingListController extends GetxController {

  //===================================>>  Accepted Booking  <<=========================================

  var acceptedBookingList = <AcceptedBookingModel>[].obs;
  var isLoading = true.obs;

  void fetchMyBookedList({String? status}) async {
    acceptedBookingList.clear();
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


      final response = await ApiClient.getData(ApiConstants.caregiverAcceptedBookingEndPoint, headers: headers);

      if (response.statusCode == 200) {
        var myCarBookingResponse =
        response.body['data']['attributes']['bookings'];

        print('Response bookings: $myCarBookingResponse');

        var bookings = List<AcceptedBookingModel>.from(
            myCarBookingResponse.map((x) => AcceptedBookingModel.fromJson(x)));

        acceptedBookingList.assignAll(bookings);
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
      isLoading(false);
    }
  }


  //===================================>>  Accepted Booking  <<=========================================

  var completedBookingList = <CompleteBookingModel>[].obs;
  var isCompleteLoading = true.obs;

  void fetchCompletedBookedList({String? status}) async {
    completedBookingList.clear();
    try {
      isCompleteLoading(true);
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


      final response = await ApiClient.getData(ApiConstants.caregiverCompletedBookingEndPoint, headers: headers);

      if (response.statusCode == 200) {
        var myCarBookingResponse =
        response.body['data']['attributes']['bookings'];

        print('Response bookings: $myCarBookingResponse');

        var bookings = List<CompleteBookingModel>.from(
            myCarBookingResponse.map((x) => CompleteBookingModel.fromJson(x)));

        completedBookingList.assignAll(bookings);
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
      isCompleteLoading(false);
    }
  }



}
