import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_health_app/controller/home_controller.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../controller/settings/localization_controller.dart';
import '../controller/settings/theme_controller.dart';
import '../models/language_model.dart';
import '../utils/app_constants.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  // Repository
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => HomeController());

  //Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();

  for (LanguageModel languageModel in AppConstants.languages) {
    try {
      String jsonStringValues = await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
      Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
      Map<String, String> _json = {};
      _mappedJson.forEach((key, value) {
        _json[key] = value.toString();
      });
      _languages['${languageModel.languageCode}_${languageModel.countryCode}'] = _json;
    }
    catch (e) {
      print('Error loading language file for ${languageModel.languageCode}: $e');
    }
  }
  return _languages;
}
