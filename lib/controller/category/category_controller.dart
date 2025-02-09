import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health_app/models/category/category_model.dart';
import 'package:home_health_app/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/category/sub_category_model.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';

class CategoryController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<String> categoryNames = <String>[].obs;
  RxList<String> subCategoryNames = <String>[].obs;
  RxList<String> subCategoryIds = <String>[].obs;
  RxList<String> subCatDescription = <String>[].obs;
  RxList<String> subCatHourRate = <String>[].obs;
  RxList<String> categoryIds = <String>[].obs;
  RxList<String> CAT_IMAGES = <String>[].obs;
  RxList<String> SUB_CAT_IMAGES = <String>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchCategory();
  }

  fetchCategory() async {
    isLoading.value = true;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);

    if (accessToken == null) {
      Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
      isLoading.value = false;
      return;
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var response = await ApiClient.getData(
      ApiConstants.allCategoryEndPoint,
      headers: headers,
    );

    if (response.statusCode == 200) {
      isLoading.value = false;

      // Parse response using the model
      var categoryResponse = CategoryResponse.fromJson(response.body);
      print('response is : ${categoryResponse.data.attributes.results}');

      for (var result in categoryResponse.data.attributes.results) {
        categoryNames.add(result.category);
        categoryIds.add(result.id);
        CAT_IMAGES.add(result.image);

      }
    } else {
      var message = response.body['message'] ?? "Unknown error";
      Get.snackbar(AppStrings.errorTextSpecial.tr, message);
    }
    isLoading.value = false;
  }

  fetchSubCategory(String categoryId) async {
    isLoading.value = true;

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(AppStrings.accessToken);

      if (accessToken == null) {
        Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
        return;
      }

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      final response = await ApiClient.getData(
        '${ApiConstants.singleCategoryEndPoint}/$categoryId',
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            response.body['data']['attributes'];
        final category = SubCategoryResponse.fromJson(responseData);

        subCategoryNames.clear();
        subCatDescription.clear();
        subCatHourRate.clear();

        subCategoryNames.addAll(category.subCategories.map((e) => e.name));
        subCategoryIds.addAll(category.subCategories.map((e) => e.id));
        subCatDescription
            .addAll(category.subCategories.map((e) => e.description));
        subCatHourRate
            .addAll(category.subCategories.map((e) => e.hourRate.toString()));
        SUB_CAT_IMAGES.addAll(category.subCategories.map((e) => e.image.url));

      }
      else {
        final message =
            response.body['message'] ?? "Unknown error";
        Get.snackbar(AppStrings.errorTextSpecial.tr, message, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red , colorText: Colors.white,);
      }
    } catch (error) {
      Get.snackbar(AppStrings.errorTextSpecial.tr, "An error occurred: $error");
    } finally {
      isLoading.value = false;
    }
  }
}
