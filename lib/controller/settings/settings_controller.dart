import 'package:get/get.dart';

import '../../service/api_client.dart';
import '../../service/api_constants.dart';

class SettingsController extends GetxController {
//==============================> Get User Terms of Service Method <==========================

  RxBool isTermsOfServiceLoading = false.obs;
  RxString termsOfServiceContent = ''.obs;

  // getTermsOfService() async {
  //   isTermsOfServiceLoading.value = true;
  //   Map<String, String> header = {'Content-Type': 'application/json'};
  //   var response = await ApiClient.getData(ApiConstants.termsOfServiceEndPoint,
  //       headers: header);
  //   if (response.statusCode == 200) {
  //     var data = response.body;
  //     var attributes = data['data']['attributes']['termsText'];
  //     termsOfServiceContent.value = attributes;
  //     isTermsOfServiceLoading.value = false;
  //   }
  // }

  //==============================> Get User Privacy Policy Method <==========================

  RxBool isPrivacyPolicyLoading = false.obs;
  RxString privacyPolicyContent = ''.obs;

  // getPrivacyPolicy() async {
  //   isPrivacyPolicyLoading.value = true;
  //   Map<String, String> header = {'Content-Type': 'application/json'};
  //   var response =
  //       await ApiClient.getData(ApiConstants.privacyEndPoint, headers: header);
  //   if (response.statusCode == 200) {
  //     var data = response.body;
  //     var attributes = data['data']['attributes']['privacyText'];
  //     privacyPolicyContent.value = attributes;
  //     isPrivacyPolicyLoading.value = false;
  //   }
  // }

//==============================> Get User About Us Method <==========================

  RxBool isAboutUsLoading = false.obs;
  RxString aboutUsContent = ''.obs;

  // getAboutUs() async {
  //   isAboutUsLoading.value = true;
  //   Map<String, String> header = {'Content-Type': 'application/json'};
  //   var response =
  //       await ApiClient.getData(ApiConstants.aboutUsEndPoint, headers: header);
  //   if (response.statusCode == 200) {
  //     var data = response.body;
  //     var attributes = data['data']['attributes']['aboutUsText'];
  //     aboutUsContent.value = attributes;
  //     isAboutUsLoading.value = false;
  //   }
  // }

  //==============================> Get User Contact Us Us Method <==========================

  RxBool isContactUsLoading = false.obs;
  RxString contactUsLoadingContent = ''.obs;

  // getContactUs() async {
  //   isContactUsLoading.value = true;
  //   Map<String, String> header = {'Content-Type': 'application/json'};
  //   var response = await ApiClient.getData(ApiConstants.contactUsEndPoint,
  //       headers: header);
  //   if (response.statusCode == 200) {
  //     var data = response.body;
  //     var attributes = data['data']['attributes']['email'];
  //     contactUsLoadingContent.value = attributes;
  //     isContactUsLoading.value = false;
  //   }
  // }
}
