import 'package:get/get.dart';
import 'package:home_health_app/helpers/route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_strings.dart';

class PaymentController extends GetxController {
  var isLoading = false.obs;

  sendTransactionIdToServer(String transactionId , String bookingId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);

    isLoading.value = true;
    var headers = {
      'Authorization': 'Bearer $accessToken'
    };
    var body = {
      "bookingId": bookingId,
      "transactionId": transactionId,
      "paymentMethod": "card",
      "currency": "USD"
    };

    var response = await ApiClient.postData(
        ApiConstants.makePaymentEndPoint, body,
        headers: headers);

    print("===============>>Api response : ${response.statusCode}");

    if (response.statusCode == 200) {
      print('response================>' + response.body['message']);

      Get.offAllNamed(AppRoutes.userHomePageScreen);

      Get.snackbar("Success", response.body['message']);
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
}
