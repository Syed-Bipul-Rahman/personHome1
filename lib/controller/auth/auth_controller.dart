import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../helpers/prefs_helpers.dart';
import '../../../../helpers/route.dart';
import '../../../../service/api_checker.dart';
import '../../../../service/api_client.dart';
import '../../../../service/api_constants.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';

class AuthController extends GetxController {
  RxBool signUpLoading = false.obs;

  ///<=============================== Sign Up Method ===========================>
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  RxString role = "".obs;
  RxString verifyEmail = "".obs;
  RxString forgotEmail = "".obs;

  signUpMethod() async {
    var fcmToken = await PrefsHelper.getString(AppConstants.fcmToken);

    signUpLoading.value = true;

    Map<String, String> body = {
      "firstName": firstNameCtrl.text,
      "lastName": lastNameCtrl.text,
      "email": emailCtrl.text,
      "password": passwordCtrl.text,
      "role": "user",
      "fcmToken": fcmToken,
    };

    var headers = {'Content-Type': 'application/json'};

    var response = await ApiClient.postData(
      ApiConstants.signUpEndPoint,
      jsonEncode(body),
      headers: headers,
    );

    print("===============>>Api response : ${response.statusCode}");

    if (response.statusCode == 201) {
      print("===============>>Api response : ${response.body}");
      Get.toNamed(AppRoutes.verifyCodeScreen, arguments: {
        AppStrings.email: emailCtrl.text,
        'role': role.value,
        AppStrings.screenType: AppStrings.signUpScreen,
      });
    } else if (response.statusCode == 409) {
      Get.snackbar(
          AppStrings.errorTextSpecial.tr, AppStrings.someThingWrong.tr);
    } else if (response.statusCode == 400) {
      var message = response.body['message'];
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    } else {
      ApiChecker.checkApi(response);
      Get.snackbar(
          AppStrings.errorTextSpecial.tr, AppStrings.someThingWrong.tr);
    }
    signUpLoading.value = false;
  }

  ///<=============================== Sign In Method ===========================>
  TextEditingController signInEmailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  PrefsHelper prefsHelper = Get.put(PrefsHelper());

  signInMethod() async {
    //FCM TOKEN
    var fcmToken = await PrefsHelper.getString(AppConstants.fcmToken);

    signUpLoading.value = true;
    Map<String, String> body = {
      "email": signInEmailCtrl.text,
      "password": passCtrl.text,
      "fcmToken": fcmToken,
    };

    var headers = {'Content-Type': 'application/json'};

    var response = await ApiClient.postData(
      ApiConstants.signInEndPoint,
      jsonEncode(body),
      headers: headers,
    );

    print("===============>>Api response : ${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = response.body;
      await prefsHelper.saveTokens(jsonResponse);
      var roleResponse = response.body['data']['attributes']['user']['role'];
      var userId = response.body['data']['attributes']['user']['id'];
      print("===============>>user role : $roleResponse");
      print("===============>>user id : $userId");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(AppStrings.userRole, roleResponse);
      prefs.setString(AppStrings.userId, userId);
      if (roleResponse == AppStrings.caregiver) {
        var caregiverName =
            response.body['data']['attributes']['user']['firstName'];

        var caregiverImageUrl =
            response.body['data']['attributes']['user']['image']['url'];
        PrefsHelper.setString(
            AppConstants.caregiverImageUrl, caregiverImageUrl);
        PrefsHelper.setString(AppConstants.caregiverName, caregiverName);

        Get.offAllNamed(AppRoutes.careGiverHomeScreen);
      } else {

        var isProfileCompleted =PrefsHelper.getBool("isCompleted");
        if(isProfileCompleted==true){
          Get.offAllNamed(AppRoutes.userHomePageScreen);
        }
        else{
          Get.offAllNamed(AppRoutes.locationPickerScreen,parameters: {
            'userToken':  response.body['data']['attributes']['tokens']['access']['token'],
          });
        }
      }
    } else if (response.statusCode == 409 || response.statusCode == 400) {
      Get.snackbar(AppStrings.errorTextSpecial.tr, response.body['message']);
      signUpLoading(false);
    } else {
      ApiChecker.checkApi(response);
      Get.snackbar(AppStrings.errorTextSpecial.tr, response.body['message']);
    }
    signUpLoading.value = false;
  }

  ///<=============================== verifyEmail Method ===========================>

  TextEditingController pinCodeCtrl = TextEditingController();

  verifyEmailMethod(String screenType) async {
    signUpLoading.value = true;

    Map<String, String> body = {
      "email": verifyEmail.value,
      "oneTimeCode": pinCodeCtrl.text,
    };

    var headers = {'Content-Type': 'application/json'};

    var response = await ApiClient.postData(
      ApiConstants.verifyEmailEndPoint,
      jsonEncode(body),
      headers: headers,
    );

    print("===============>>Api response : ${response.statusCode}");

    if (response.statusCode == 200) {
      print("===============>>Api response : ${response.body}");
      if (screenType == AppStrings.forgetPasswordScreen) {
        Get.toNamed(AppRoutes.setNewPasswordScreen, arguments: {
          AppStrings.email: verifyEmail.value,
        });
      } else {
        Get.offAllNamed(AppRoutes.signInScreen);

        // var tokent=response.body['data']['attributes']['tokens']['access']['token'];
        // PrefsHelper.setString(AppStrings.accessToken,tokent);
        // Get.toNamed(AppRoutes.fillUpProfileInfoScreen, arguments: {
        //   'role': role.value,
        //   'userId': response.body['data']['attributes']['user']['id'],
        //   'userToken': tokent,
        // });

      }
      Get.snackbar(AppStrings.success, AppStrings.yourEmailIsVerified.tr);
      pinCodeCtrl.text = "";
    } else if (response.statusCode == 409) {
      Get.snackbar(AppStrings.errorTextSpecial.tr, response.body['message']);
    } else if (response.statusCode == 400) {
      var message = response.body['message'];
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    } else {
      ApiChecker.checkApi(response);
      var message = response.body['message'];
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    }
    signUpLoading.value = false;
  }

  //========================= forgot password ========================

  TextEditingController forgotPassCtrl = TextEditingController();

  forgotPasswordMethod() async {
    signUpLoading.value = true;

    Map<String, String> body = {
      "email": forgotEmail.value,
    };

    var headers = {'Content-Type': 'application/json'};

    var response = await ApiClient.postData(
      ApiConstants.forgotPasswordEndPoint,
      jsonEncode(body),
      headers: headers,
    );

    print("===============>>Api response : ${response.statusCode}");

    if (response.statusCode == 200) {
      print("===============>>Api response : ${response.body}");
      Get.snackbar(AppStrings.success, response.body['message']);

      Get.toNamed(AppRoutes.verifyCodeScreen, arguments: {
        'role': role.value,
        AppStrings.email: forgotEmail.value,
        AppStrings.screenType: AppStrings.forgetPasswordScreen,
      });
    } else if (response.statusCode == 409) {
      Get.snackbar(
          AppStrings.errorTextSpecial.tr, AppStrings.someThingWrong.tr);
    } else if (response.statusCode == 400) {
      var message = response.body['message'];
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    } else {
      ApiChecker.checkApi(response);
      var message = response.body['message'];
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    }
    signUpLoading.value = false;
  }

  //====================================== set new password ========================

  TextEditingController setNewPass = TextEditingController();

  setNewPasswordMethod() async {
    signUpLoading.value = true;

    Map<String, String> body = {
      "email": verifyEmail.value,
      "password": setNewPass.text,
    };

    var headers = {'Content-Type': 'application/json'};

    var response = await ApiClient.postData(
      ApiConstants.setNewPasswordEndPoint,
      jsonEncode(body),
      headers: headers,
    );

    print("===============>>Api response : ${response.statusCode}");

    if (response.statusCode == 200) {
      print("===============>>Api response : ${response.body}");

      Get.snackbar(AppStrings.success, AppStrings.yourEmailIsVerified.tr);
      Get.offAllNamed(AppRoutes.signInScreen, arguments: {
        'role': role.value,
      });

      pinCodeCtrl.text = "";
    } else if (response.statusCode == 409) {
      Get.snackbar(
          AppStrings.errorTextSpecial.tr, AppStrings.someThingWrong.tr);
    } else if (response.statusCode == 400) {
      var message = response.body['message'];
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    } else {
      ApiChecker.checkApi(response);
      var message = response.body['message'];
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    }
    signUpLoading.value = false;
  }

//========================= change password ========================

  TextEditingController oldPassCtrl = TextEditingController();
  TextEditingController newPassCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();

  var changePassLoading = false.obs;

  changePasswordMethod() async {
    changePassLoading.value = true;

    Map<String, String> body = {
      "oldPassword": oldPassCtrl.text,
      "newPassword": newPassCtrl.text,
    };

    if (newPassCtrl.text != confirmPassCtrl.text) {
      Get.snackbar(AppStrings.errorTextSpecial.tr, "Password does not match");
      changePassLoading.value = false;
      return;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var response = await ApiClient.postData(
      ApiConstants.changePasswordEndPoint,
      jsonEncode(body),
      headers: headers,
    );

    print("===============>>Api response : ${response.statusCode}");

    if (response.statusCode == 200) {
      print("===============>>Api response : ${response.body}");

      Get.snackbar(AppStrings.success, response.body['message']);
      Get.toNamed(AppRoutes.profileScreen);
    } else if (response.statusCode == 409) {
      Get.snackbar(AppStrings.errorTextSpecial.tr, response.body['message']);
    } else if (response.statusCode == 400) {
      var message = response.body['message'];
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    } else {
      ApiChecker.checkApi(response);
      var message = response.body['message'];
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    }
    changePassLoading.value = false;
  }
}
