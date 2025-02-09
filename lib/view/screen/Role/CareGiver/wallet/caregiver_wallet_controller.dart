import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health_app/view/screen/Role/CareGiver/wallet/caregiver_wallet_model.dart';
import 'package:home_health_app/view/screen/Role/CareGiver/wallet/withdraw_requests/withraw_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_constants.dart';
import '../../../../../utils/app_strings.dart';

class CaregiverWalletController extends GetxController {
  var isLoading = true.obs;

  var walletInfo = CareGiverWalletModel().obs;

  var userBalance = 0.0.obs;
  getWalletInfo() async {
    try {
      isLoading(true);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(AppStrings.accessToken);

      if (accessToken == null) {
        Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
        return;
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };

      final response = await ApiClient.getData(ApiConstants.walletEndPoint,
          headers: headers);

      if (response.statusCode == 200) {
        var walletInfosa = response.body['data']['attributes'];
        userBalance.value = walletInfosa['balance'].toDouble();
        walletInfo.value = CareGiverWalletModel.fromJson(walletInfosa);
        print('Single booking =========> : $walletInfo');
      } else {
        var message = response.body['message'] ?? "Unknown error";
        Get.snackbar(AppStrings.errorTextSpecial.tr, message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('Error fetching bookings: $e');
      Get.snackbar(AppStrings.errorTextSpecial.tr, '$e',
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  //get wallet history
  RxList<Transaction> transactions = <Transaction>[].obs;

  Future<void> getWalletHistory() async {
    try {
      isLoading(true);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(AppStrings.accessToken);

      if (accessToken == null) {
        Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
        return;
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };

      final response = await ApiClient.getData(
        ApiConstants.requestHistorylist,
        headers: headers,
      );

      if (response.statusCode == 200) {
        var walletHistory = response.body['data']['attributes']['results'] as List;

        // Explicitly cast each item to Transaction
        transactions.value = walletHistory.map((json) {
          try {
            return Transaction.fromJson(Map<String, dynamic>.from(json));
          } catch (e) {
            print('Error parsing transaction: $e');
            rethrow;
          }
        }).toList();

      } else {
        var message = response.body['message'] ?? "Unknown error";
        Get.snackbar(
            AppStrings.errorTextSpecial.tr,
            message,
            backgroundColor: Colors.red,
            colorText: Colors.white
        );
      }
    } catch (e) {
      print('Error ==================================>: $e');
      Get.snackbar(
          AppStrings.errorTextSpecial.tr,
          'Failed to load wallet history: $e',
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
    } finally {
      isLoading(false);
    }
  }
}
