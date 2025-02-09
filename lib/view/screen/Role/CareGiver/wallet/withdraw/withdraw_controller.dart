import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../service/api_checker.dart';
import '../../../../../../service/api_client.dart';
import '../../../../../../service/api_constants.dart';
import '../../../../../../utils/app_strings.dart';
import '../caregiver_wallet_controller.dart';

class WithdrawController extends GetxController {
  var isWithdrawLoading = false.obs;

  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController securityCodeController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  CaregiverWalletController _caregiverWalletController =
      Get.put(CaregiverWalletController());

  // ====================>> Withdraw Request ====================
  sendWithDrawRequest() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);

    isWithdrawLoading.value = true;
    Map<String, dynamic> body = {
      "amount": amountController.text,
      "cardholderName": cardHolderNameController.text,
      "cardNumber": cardNumberController.text,
      "cvv": cvvController.text,
      "code": securityCodeController.text
    };

    var headers = {'Authorization': 'Bearer $accessToken'};

    var response = await ApiClient.postData(
      ApiConstants.caregiverWithdrawEndPoint,
      body,
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("===============>>Api response : ${response.body}");
      isWithdrawLoading.value = false;
      Get.back();
      Get.snackbar("Request sent", response.body['message']);
      update();
    } else if (response.statusCode == 409) {
      Get.snackbar(AppStrings.errorTextSpecial.tr, response.body['message']);
    } else {
      ApiChecker.checkApi(response);
      Get.snackbar(AppStrings.errorTextSpecial.tr, response.body['message']);
    }
    isWithdrawLoading.value = false;
  }

  @override
  void onClose() {
    _caregiverWalletController.getWalletInfo();

    // TODO: implement onClose
    super.onClose();
  }
}
