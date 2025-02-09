import 'package:get/get.dart';

import '../../models/common_privacy_terms_about_model.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';
import '../../utils/app_strings.dart';

class PrivacyPolicyController extends GetxController {
  @override
  onInit() {
    super.onInit();
    fetchPrivacyPolicy();
    fetchTermsConditions();
    fetchAboutUs();
  }

  RxBool isLoading = false.obs;

  RxString text = ''.obs;
  RxString termsText = ''.obs;
  RxString aboutUsText = ''.obs;

  fetchPrivacyPolicy() async {
    isLoading.value = true;

    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await ApiClient.getData(
      ApiConstants.privacyPolicyEndPoint,
      headers: headers,
    );

    if (response.statusCode == 200) {
      isLoading.value = false;

      // Parse response using the model
      var privacyPolicyResponse = PrivacyPolicyResponse.fromJson(response.body);
      print('Response: ${privacyPolicyResponse.data.attributes}');
      text.value = privacyPolicyResponse.data.attributes.text;
    } else {
      var message = response.body['message'] ?? "Unknown error";
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    }
    isLoading.value = false;
  }

  fetchTermsConditions() async {
    isLoading.value = true;

    var headers = {
      'Content-Type': 'application/json',
    };

    var responseTerms = await ApiClient.getData(
      ApiConstants.termsConditionsEndPoint,
      headers: headers,
    );

    if (responseTerms.statusCode == 200) {
      isLoading.value = false;

      // Parse response using the model
      var privacyPolicyResponse = PrivacyPolicyResponse.fromJson(responseTerms.body);
      print('Response: ${privacyPolicyResponse.data.attributes}');
      termsText.value = privacyPolicyResponse.data.attributes.text;
    } else {
      var message = responseTerms.body['message'] ?? "Unknown error";
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    }
    isLoading.value = false;
  }


  fetchAboutUs() async {
    isLoading.value = true;

    var headers = {
      'Content-Type': 'application/json',
    };

    var responseAbout = await ApiClient.getData(
      ApiConstants.aboutUsEndPoint,
      headers: headers,
    );

    if (responseAbout.statusCode == 200) {
      isLoading.value = false;

      // Parse response using the model
      var privacyPolicyResponse = PrivacyPolicyResponse.fromJson(responseAbout.body);
      print('Response: ${privacyPolicyResponse.data.attributes}');
      aboutUsText.value = privacyPolicyResponse.data.attributes.text;
    } else {
      var message = responseAbout.body['message'] ?? "Unknown error";
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    }
    isLoading.value = false;
  }
}
