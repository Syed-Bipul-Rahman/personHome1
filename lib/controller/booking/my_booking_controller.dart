import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/booking/booking_details_model.dart';
import '../../models/booking/my_booking_model.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';
import '../../utils/app_strings.dart';

class MyBookingController extends GetxController {
  var myBookingList = <Booking>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchMyBooking();
    super.onInit();
  }

  void fetchMyBooking({String? status}) async {
    myBookingList.clear();
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

      final endpoint = status != null
          ? '${ApiConstants.myBookingEndPoint}?status=$status'
          : ApiConstants.myBookingEndPoint;

      final response = await ApiClient.getData(endpoint, headers: headers);

      if (response.statusCode == 200) {
        var myCarBookingResponse =
        response.body['data']['attributes']['bookings'];

        print('Response bookings: $myCarBookingResponse');

        var bookings = List<Booking>.from(
            myCarBookingResponse.map((x) => Booking.fromJson(x)));

        myBookingList.assignAll(bookings);
      } else {
        var message = response.body['message'] ?? "Unknown error";
        Get.snackbar(AppStrings.errorTextSpecial.tr, message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('Error fetching bookings: $e');
      Get.snackbar(AppStrings.errorTextSpecial.tr, e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  //================================== My Booking Details ==================================
var myBookingDetails = BookingDetails().obs;



  void fetchMyBookingDetails( String bookingId) async {
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


      final response = await ApiClient.getData('${ApiConstants.myBookingDetailsEndPoint}/$bookingId', headers: headers);

      if (response.statusCode == 200) {
        var myCarBookingResponse =
        response.body['data']['attributes'];

        myBookingDetails.value = BookingDetails.fromJson(myCarBookingResponse);


        print('Single booking =========> : $myCarBookingResponse');
        update();

      } else {
        var message = response.body['message'] ?? "Unknown error";
        Get.snackbar(AppStrings.errorTextSpecial.tr, message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('Error fetching bookings: $e');
      Get.snackbar(AppStrings.errorTextSpecial.tr, e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoading(false);
    } finally {
      isLoading(false);
      update();
    }
  }



}
