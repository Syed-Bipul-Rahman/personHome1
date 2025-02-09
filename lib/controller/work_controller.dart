import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:home_health_app/helpers/route.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/app_constants.dart';
import '../helpers/showLog.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_strings.dart';

class WorkController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    loadHasStartedWork();
  }


  RxBool isLoading = false.obs;
  var bookingId = ''.obs;
  var hasStartedWork = false.obs;


  startWork() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);

    isLoading.value = true;
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var response = await ApiClient.patchData(
      '${ApiConstants.startWorkPostEndPoint}/${bookingId.value}',
      headers: headers,
    );

    print("===============>>Api response : ${response.statusCode}");

    if (response.statusCode == 200) {

      hasStartedWork.value = true;
      prefs.setBool('hasStartedWork', true);
      if (kDebugMode) {
        print('response================>' + response.body['message']);
        print("===============>>work started");
      }
      isLoading.value = false;
      update();
      Get.back();
    } else if (response.statusCode == 409) {
      Get.snackbar(
          AppStrings.errorTextSpecial.tr, response.body['message'] ?? '');
    } else {
      ApiChecker.checkApi(response);
      Get.snackbar(
          AppStrings.errorTextSpecial.tr, response.body['message'] ?? '');
    }
    isLoading.value = false;
  }

  //========================================>>  Send payment request   <<====================================================

  RxBool isPaymentRequestLoading = false.obs;
  var workTime = 0.obs;

  sendPaymentRequest({required double workTime}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);

    isLoading.value = true;
    var headers = {
      // 'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    var body = {
      "bookingId": bookingId.value,
      "workTime": workTime.toString()
    };

    showLog('body================>' + body.toString());

    var response = await ApiClient.postData(
        ApiConstants.sendPaymentRequestEndPoint, body,
        headers: headers);

    print("===============>>Api response : ${response.statusCode}");

    if (response.statusCode == 200) {
      print('response================>' + response.body['message']);

      await prefs.remove(AppConstants.startTimeKey);

      hasStartedWork.value = false;
      prefs.setBool('hasStartedWork', false);

      isPaymentRequestLoading.value = false;
      update();
      Get.offAllNamed(AppRoutes.careGiverHomeScreen);

      Get.snackbar("Success", response.body['message']);
    } else if (response.statusCode == 409) {
      Get.snackbar(
          AppStrings.errorTextSpecial.tr, response.body['message'] ?? '');
    } else {
      ApiChecker.checkApi(response);
      Get.snackbar(
          AppStrings.errorTextSpecial.tr, response.body['message'] ?? '');
    }
    isPaymentRequestLoading.value = false;
  }

  void loadHasStartedWork() async {
    final prefs = await SharedPreferences.getInstance();
    hasStartedWork.value = prefs.getBool('hasStartedWork') ?? false;
  }
}
