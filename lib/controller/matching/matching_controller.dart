import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/matching/matching_model.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';
import '../../utils/app_strings.dart';

class MatchingController extends GetxController {
  var minRange = 0.obs;
  var maxRange = 0.obs;

  List<CaregiverMatching> caregiverMatchingList = <CaregiverMatching>[].obs;

  void setMinRange(int value) {
    minRange.value = value;
  }

  void setMaxRange(int value) {
    maxRange.value = value;
  }

  var isLoading = true.obs;

  getMatchingData() async {
    if (caregiverMatchingList.isNotEmpty) {
      caregiverMatchingList.clear();
    }

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
        'Authorization': 'Bearer $accessToken',
      };

      final response = await ApiClient.getData(
          '${ApiConstants.matchingEndPoint}${minRange.value}&maxRange=${maxRange.value}',
          headers: headers);

      if (response.statusCode == 200) {
        var responses = response.body['data']['attributes'] as List;

        print('Matching list =========> : $responses');

        caregiverMatchingList = responses
            .map((e) => CaregiverMatching.fromJson(e as Map<String, dynamic>))
            .toList();

        isLoading(false);
        update();
      } else {
        var message = response.body['message'] ?? "Unknown error";
        Get.snackbar(AppStrings.errorTextSpecial.tr, message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('Error fetching matching: $e');
      Get.snackbar(AppStrings.errorTextSpecial.tr, e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoading(false);
    } finally {
      isLoading(false);
      update();
    }
  }
}
