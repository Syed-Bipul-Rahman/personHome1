import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health_app/helpers/route.dart';
import 'package:home_health_app/service/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/api_checker.dart';
import '../../service/api_client.dart';
import '../../utils/app_strings.dart';

class ApplyJobController extends GetxController {
  TextEditingController fullNameCTRL = TextEditingController();
  TextEditingController emailCTRL = TextEditingController();
  TextEditingController phoneNumberCTRL = TextEditingController();
  TextEditingController jobPositionCTRL = TextEditingController();
  TextEditingController companyNameCTRL = TextEditingController();
  TextEditingController jobTitleCTRL = TextEditingController();
  TextEditingController durationCTRL = TextEditingController();
  TextEditingController keyResponsibilityCTRL = TextEditingController();
  TextEditingController experienceDegreeCTRL = TextEditingController();
  TextEditingController instituteCTRL = TextEditingController();
  TextEditingController completeYearCTRL = TextEditingController();
  TextEditingController coverLetterCTRL = TextEditingController();
  TextEditingController educationCTRL = TextEditingController();

  RxString? imagePath = ''.obs;
  RxString? resumeFileName = ''.obs;
  RxString? resumeFilePath = ''.obs;
  RxString? jobPostId = ''.obs;
  RxBool isLoading = false.obs;

  List<String> completeYearsItems = [
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
  ];



  applyForJob() async {
    isLoading.value = true;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);

    if (accessToken == null) {
      Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
      isLoading.value = false;
      return;
    }

    List<MultipartBody> multipartBody = [
      MultipartBody('image', File(imagePath!.value)),
      MultipartBody('resume', File(resumeFilePath!.value)),
    ];

    Map<String, String> body = {
      'name': fullNameCTRL.text,
      'email': emailCTRL.text,
      'phone_number': phoneNumberCTRL.text,
      'job_position': jobPositionCTRL.text,
      'experience': experienceDegreeCTRL.text,
      'duration': durationCTRL.text,
      'education': educationCTRL.text,
      'institution': instituteCTRL.text,
      'complete_year': completeYearCTRL.text,
      'job_post_id': jobPostId!.value,
      'cover_letter': coverLetterCTRL.text,
    };

    print("body ==============> $body");

    // Headers
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    // API call with multipart data
    var response = await ApiClient.postMultipartData(
      ApiConstants.applyJobEndPoint,
      body,
      headers: headers,
      multipartBody: multipartBody,
    );

    // Handle response
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.toNamed(AppRoutes.userHomePageScreen);
      Get.snackbar(
          AppStrings.successfulText.tr, response.body['message'],
          backgroundColor: Colors.green[200], colorText: Colors.green[900]);

    }else if(response.statusCode == 400){
      Get.toNamed(AppRoutes.userHomePageScreen);
      Get.snackbar(
          AppStrings.successfulText.tr, response.body['message'],
          backgroundColor: Colors.green[200], colorText: Colors.green[900]);
    } else {
      Get.snackbar(AppStrings.errorTextSpecial.tr, response.body['message'],
          backgroundColor: Colors.red[200], colorText: Colors.red[900]);
      ApiChecker.checkApi(response);
    }
  }
}
