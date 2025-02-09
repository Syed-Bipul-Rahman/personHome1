import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:home_health_app/utils/app_colors.dart';


class AppCustomToast {

  // Method to show a toast message
  static void showCustomToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        backgroundColor: AppColors.primaryColor
    );
  }
  // Method to show a toast message
  static void statusToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        backgroundColor: AppColors.primaryColor
    );
  }

  // Method to show a snackbar notification
  static void showIphoneSnackbar(String title, String message, int seconds) {
    Get.snackbar(
      title,
      message,
      duration: Duration(seconds: seconds),
    );
  }

}
