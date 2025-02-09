import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health_app/helpers/prefs_helpers.dart';
import 'package:home_health_app/helpers/route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/api_checker.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';
import '../../utils/app_strings.dart';
import '../../view/screen/Role/User/profile/use_info_model.dart';

class ProfileInfoController extends GetxController {
  final List<String> gender = ['male', 'female', 'other'];
  RxString selectedGender = ''.obs;

  var isProfileLoading = false.obs;
  var userId = ''.obs;

  var userInfo = UserInfoModel().obs;

  getMyInfo() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(AppStrings.accessToken);

      if (accessToken == null) {
        Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
        return;
      }

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      final response = await ApiClient.getData(
        '${ApiConstants.profileEndPoint}/$userId',
        headers: headers,
      );

      if (response.statusCode == 200) {
        final responseData = response.body['data']['attributes']['user'];
        userInfo.value = UserInfoModel.fromJson(responseData);
      } else {
        final message = response.body['message'] ?? "Unknown error";
        Get.snackbar(
          AppStrings.errorTextSpecial.tr,
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      Get.snackbar(AppStrings.errorTextSpecial.tr, "An error occurred: $error");
    } finally {
      isProfileLoading.value = false;
    }
  }

  ///================= Text Editing Controllers ===================///

  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController genderCtrl = TextEditingController();
  TextEditingController dateOfBirthCtrl = TextEditingController();

  ///================= Update Profile Info ===================///

  var updateProfileLoading = false.obs;

  updateProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);

    updateProfileLoading.value = true;
    var headers = {'Authorization': 'Bearer $accessToken'};

    var body = {
      "gender": genderCtrl.text,
      "phone": phoneNumberCtrl.text,
      "dataOfBirth": dateOfBirthCtrl.text,
      // "email": emailCtrl.text,
    };

    var response = await ApiClient.patchData(
        '${ApiConstants.profileEndPoint}/${userId.value}',
        headers: headers,
        body: body);

    print("===============>>Api response : ${response.statusCode}");

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('response================>' + response.body['message']);
      }
      updateProfileLoading.value = false;
      update();
      Get.toNamed(AppRoutes.profileScreen);
    } else if (response.statusCode == 409) {
      Get.snackbar(
          AppStrings.errorTextSpecial.tr, response.body['message'] ?? '');
    } else {
      ApiChecker.checkApi(response);
      Get.snackbar(
          AppStrings.errorTextSpecial.tr, response.body['message'] ?? '');
    }
    updateProfileLoading.value = false;
  }

  ///================= Update Profile Info ===================///
  // TextEditingController mobileNumberInfoCTRL = TextEditingController();
  TextEditingController phoneNumCTRL = TextEditingController();
  TextEditingController addressCTRL = TextEditingController();
  TextEditingController dOBcTRL = TextEditingController();

  var isupdateLoading = false.obs;
  RxString? imagePath = ''.obs;

  updateProfileInfo(String userId) async {
    isupdateLoading.value = true;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);

    if (accessToken == null) {
      Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
      isupdateLoading.value = false;
      return;
    }

    List<MultipartBody> multipartBody = [
      MultipartBody('image', File(imagePath!.value)),
    ];

    Map<String, String> body = {
      'gender': selectedGender.value,
      'phone': phoneNumCTRL.text,
      'address': addressCTRL.text,
      'dataOfBirth': dOBcTRL.text,
      'role': "user",
    };

    print("body ==============> $body");

    // Headers
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $accessToken',
    };
    // API call with multipart data
    var response = await ApiClient.patchMultipartData(
      "${ApiConstants.fillUpProfileEndPoint}/$userId",
      body,
      headers: headers,
      multipartBody: multipartBody,
    );

    // Handle response
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar(AppStrings.successfulText.tr, response.body['message'],
          backgroundColor: Colors.green[200], colorText: Colors.green[900]);
      Get.offAllNamed(AppRoutes.userHomePageScreen);
    } else {
      Get.snackbar(AppStrings.errorTextSpecial.tr, response.body['message'],
          backgroundColor: Colors.red[200], colorText: Colors.red[900]);
      ApiChecker.checkApi(response);
    }
  }

  ///================= Update Profile Location ===================///

  var updateLocationLoading = false.obs;
  var latitude = ''.obs;
  var longitude = ''.obs;
  var locationName = ''.obs;

  updateProfileLocation(String token) async {
    isupdateLoading.value = true;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);

    if (accessToken == null) {
      Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
      isupdateLoading.value = false;
      return;
    }

    Map<String, String> body = {
      "latitude": latitude.value,
      "longitude": longitude.value,
      "locationName": locationName.value
    };

    print("body ==============> $body");

    // Headers
    var headers = {
      'Authorization': 'Bearer $accessToken',
    };
    var response = await ApiClient.postData(
      ApiConstants.locationUpdateEndPoint,
      body,
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {

      Get.offAllNamed(AppRoutes.userHomePageScreen);
      PrefsHelper.setBool("isCompleted", true);
      Get.snackbar(AppStrings.successfulText.tr, response.body['message'],
          backgroundColor: Colors.green[200], colorText: Colors.green[900]);
    } else {
      Get.snackbar(AppStrings.errorTextSpecial.tr, response.body['message'],
          backgroundColor: Colors.red[200], colorText: Colors.red[900]);
      ApiChecker.checkApi(response);
    }
  }
}
