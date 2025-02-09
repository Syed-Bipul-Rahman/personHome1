import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../service/api_checker.dart';
import '../../../service/api_client.dart';
import '../../../service/api_constants.dart';


class CommonLocationController extends GetxController {
  var locationNameController = TextEditingController();

  var setLocationLoading = false.obs;
  var latitude = "".obs;
  var longitude = "".obs;

  setLocation({required String latitude, required String longitude}) async {
    try {
      var body = {
        "latitude": latitude,
        "longitude": longitude,
        "locationName": locationNameController.text,
      };

      //TODO: use real token here ======================>>>
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2NzhmM2UyNDUyOWEyOTc2YjQ1MDgwMmIiLCJpYXQiOjE3Mzc0NTM1MzAsImV4cCI6MTc0MDk5MDk4MzU5NCwidHlwZSI6ImFjY2VzcyJ9.Zs9HkPtPPq8kBkteA1ZvIQfCvYX1PPNbihcSybPOa-o',
      };
      //TODO: use real token here <<<====================

      setLocationLoading(true);
      Response response = await ApiClient.postData(
          ApiConstants.matchingEndPoint, jsonEncode(body),
          headers: headers);
      print("============> ${response.body} and ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Hurray! Your Location is set");

        Fluttertoast.showToast(
            msg: "Hurray!🥳 \n Your Location is set successfully");
        setLocationLoading(false);
      } else {
        ApiChecker.checkApi(response);
        Fluttertoast.showToast(msg: response.statusText ?? "");
      }
    } catch (e, s) {
      print("===> e : $e");
      print("===> s : $s");
    }
    setLocationLoading(false);
  }


}
