import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health_app/helpers/route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/api_checker.dart';
import '../../service/api_client.dart';
import '../../service/api_constants.dart';
import '../../utils/app_strings.dart';

class AddTaskController extends GetxController {
  RxList<String> taskList = <String>[].obs;
  RxInt editingIndex = (-1).obs;

  final TextEditingController descriptionTextCtrl = TextEditingController();
  final TextEditingController singleTaskTextCtrl = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final TextEditingController tasklistController = TextEditingController();

  List<String> taskListDropdown = [
    "Shampoo Halr",
    "Shave_Electric_Safety Razor",
    "Skin Care",
    "Bed / Sponge Bath",
    "Perineal Care",
    "Tub Bath Bench_Hand Spray",
    "Shower LOnairl Hand Spray",
    "Lotion",
    "Nall Care_Clean_File",
    "Dressing Assistance",
    "Remove/Apply Elastic Bandage",
    "Foot Care",
    "Oral/Dental Care",
    "Elevate Feet",
    "MOBILITV",
    "Wheelchalr Activities",
    "Assistive DevicesCanes_Walkers",
    "Ambulation"
  ];

  @override
  void onClose() {
    descriptionTextCtrl.dispose();
    singleTaskTextCtrl.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void addTask() {
    if (singleTaskTextCtrl.text.isNotEmpty) {
      if (editingIndex.value >= 0) {
        // Update existing task
        taskList[editingIndex.value] = singleTaskTextCtrl.text;
        editingIndex.value = -1;
      } else {
        // Add new task
        taskList.add(singleTaskTextCtrl.text);
      }
      singleTaskTextCtrl.clear();

      Future.delayed(const Duration(milliseconds: 100), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void startEditing(int index, String currentText) {
    editingIndex.value = index;
    singleTaskTextCtrl.text = currentText;
  }

  void cancelEditing() {
    editingIndex.value = -1;
    singleTaskTextCtrl.clear();
  }

  void removeTask(int index) {
    if (index >= 0 && index < taskList.length) {
      taskList.removeAt(index);
      if (editingIndex.value == index) {
        cancelEditing();
      }
    }
  }

  //============================ >> Create Booking << =================================

  var categoryId = ''.obs;
  var subCategoryId = ''.obs;

  var isBookLoading = false.obs;

  Future<void> bookTask() async {


    print("convertedList: ${convertTasksToServiceTasks(taskList)}");

    if (taskList.isEmpty) {
      if (Get.isSnackbarOpen) return;
      Get.snackbar(
        'Error',
        'Please add at least one task',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    if (descriptionTextCtrl.text.isEmpty) {
      if (Get.isSnackbarOpen) return;
      Get.snackbar(
        'Error',
        'Please add a description',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      );
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);

    Map<String, dynamic> body = {
      "subcategory_Id": subCategoryId.value.toString(),
      "categoryId": categoryId.value.toString(),
      "description": descriptionTextCtrl.text.toString(),
      "serviceTasks": convertTasksToServiceTasks(taskList),
    };
    print(body);
    print("Bearer Token: $accessToken");

    isBookLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var response = await ApiClient.postData(
      ApiConstants.createTaskEndPoint,
      jsonEncode(body),
      headers: headers,
    );

    print("===============>>Api response : ${response.statusCode}");

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("===============>>Api response : ${response.body}");
      descriptionTextCtrl.clear();
      isBookLoading(false);
     Get.offAndToNamed(AppRoutes.carePlanScreen);
      update();
    } else if (response.statusCode == 409) {
      if (Get.isSnackbarOpen) return;
      Get.snackbar("Error", response.body['message']);
      isBookLoading(false);
      update();
    } else if (response.statusCode == 400) {
      if (Get.isSnackbarOpen) return;
      Get.snackbar("Error", response.body['message']);
      isBookLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      if (Get.isSnackbarOpen) return;
      Get.snackbar("Error", response.body['message']);
      isBookLoading(false);
      update();
    }
    isBookLoading(false);
  }

  //============================ >> Method to convert list to object << =================================
  List<Map<String, String>> convertTasksToServiceTasks(
      RxList<String> taskList) {
    return taskList.map((task) => {"task": task}).toList();
  }
}