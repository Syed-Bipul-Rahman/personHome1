import 'dart:convert';

import 'package:get/get.dart';
import 'package:home_health_app/models/training_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_strings.dart';

class TutorialController extends GetxController {


  final RxBool isLoading = RxBool(false);
  final RxList<TrainingModel> trainingList = RxList<TrainingModel>([]);

  Future<void> fetchTutorials() async {
    isLoading.value = true;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);

    if (accessToken == null) {
      Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
      isLoading.value = false;
      return;
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    try {
      final response = await ApiClient.getData(ApiConstants.trainingEndPoint, headers: headers);

      if (response.statusCode == 200) {
        final data = response.body as Map<String, dynamic>;
        final results = data['data']['attributes']['results'] as List<dynamic>;

        trainingList.value = results.map((e) => TrainingModel.fromJson(e)).toList();
      } else {
        final message = response.body['message'] ?? "Unknown error";
        Get.snackbar(AppStrings.errorTextSpecial.tr, message);
      }
    } on Exception catch (error) {
      print('Error fetching trainings: $error');
      Get.snackbar(AppStrings.errorTextSpecial.tr, 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

}
