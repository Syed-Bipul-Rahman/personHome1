import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/route.dart';
import '../../service/api_checker.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';
import '../../utils/app_strings.dart';

class FillUpProfileInfoController extends GetxController{
  var isLoading = false.obs;
  RxString? imagePath = ''.obs;
  var gender= ''.obs;
  //
  // updateProfileInfo() async {
  //   isLoading.value = true;
  //
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? accessToken = prefs.getString(AppStrings.accessToken);
  //
  //   if (accessToken == null) {
  //     Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
  //     isLoading.value = false;
  //     return;
  //   }
  //
  //   List<MultipartBody> multipartBody = [
  //     MultipartBody('image', File(imagePath!.value)),
  //   ];
  //
  //   Map<String, String> body = {
  //     'gender':gender.value,
  //     'phone': phoneNumberCTRL.text,
  //     'address': jobPositionCTRL.text,
  //     'dataOfBirth': experienceDegreeCTRL.text,
  //     'role':"user",
  //   };
  //
  //   print("body ==============> $body");
  //
  //   // Headers
  //   var headers = {
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //   };
  //   // API call with multipart data
  //   var response = await ApiClient.postMultipartData(
  //     ApiConstants.fillUpProfileEndPoint+,
  //     body,
  //     headers: headers,
  //     multipartBody: multipartBody,
  //   );
  //
  //   // Handle response
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     Get.snackbar(
  //         AppStrings.successfulText.tr, response.body['message'],
  //         backgroundColor: Colors.green[200], colorText: Colors.green[900]);
  //     Get.toNamed(AppRoutes.userHomePageScreen);
  //   } else {
  //     Get.snackbar(AppStrings.errorTextSpecial.tr, response.body['message'],
  //         backgroundColor: Colors.red[200], colorText: Colors.red[900]);
  //     ApiChecker.checkApi(response);
  //   }
  // }


}