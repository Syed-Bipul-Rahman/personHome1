import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_health_app/controller/task/add_task_controller.dart';
import 'package:home_health_app/service/api_constants.dart';
import 'package:home_health_app/view/base/custom_dropdown.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_images.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../../utils/style.dart';
import '../../../../../base/custom_button.dart';
import '../../../../../base/custom_outline_button.dart';
import '../../../../../base/custom_text.dart';
import '../../../../../base/custom_text_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final AddTaskController _addTaskController = Get.put(AddTaskController());
  var subCategoryName = '';
  var hourlyRate = '';
  var catImage = '';

  @override
  void initState() {
    subCategoryName = Get.parameters['subcategoryName']!;
    _addTaskController.categoryId.value = Get.parameters['catId']!;
    _addTaskController.subCategoryId.value = Get.parameters['subCatId']!;
    hourlyRate = Get.parameters['subCatPrice']!;
    catImage = Get.parameters['subCatImage']!;
    print(
        "============================>> hourly rate: $hourlyRate <<============================");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              child: Stack(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: true,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  // Image widget
                  Image.network(
                    ApiConstants.baseUrl + catImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(
                subCategoryName.toString(),
                style: AppStyles.fontSize20(
                    fontWeight: FontWeight.w700, color: AppColors.primaryColor),
              ),
            ),

            // Task Section
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Container(
                    height: 20.sp,
                    width: 8.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      AppStrings.task,
                      style: AppStyles.fontSize20(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
            ),

            // Task List
            Obx(() => Container(
                  constraints: BoxConstraints(maxHeight: 200),
                  child: _addTaskController.taskList.isEmpty
                      ? const SizedBox.shrink()
                      : ListView.builder(
                          controller: _addTaskController.scrollController,
                          reverse: true,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: _addTaskController.taskList.length,
                          itemBuilder: (context, index) {
                            final reverseIndex =
                                _addTaskController.taskList.length - 1 - index;
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 8.0),
                              child: CustomOutlineButton(
                                label:
                                    _addTaskController.taskList[reverseIndex],
                                onEdit: (currentText) {
                                  _addTaskController.startEditing(
                                      reverseIndex, currentText);
                                },
                                onDelete: () =>
                                    _addTaskController.removeTask(reverseIndex),
                              ),
                            );
                          },
                        ),
                )),

            // Task Dropdown
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomDropdown(
                  selectedValue: _addTaskController.tasklistController.text,
                  items: _addTaskController.taskListDropdown,
                  hint: "Select Task",
                  controller: _addTaskController.tasklistController,
                  onChanged: (value) {
                    if (!_addTaskController.taskList.contains(value!)) {
                      _addTaskController.taskList.add(value);
                    }
                    print("Selected value: $value");
                  }),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0),
              child: Row(
                children: [
                  Container(
                    height: 20.sp,
                    width: 8.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppStrings.description,
                      style: AppStyles.fontSize20(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: CustomTextField(
                hintText: AppStrings.description,
                controller: _addTaskController.descriptionTextCtrl,
                maxLines: 5,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Row(
                children: [
                  CustomText(
                    text: AppStrings.total,
                    color: AppColors.assColorColor,
                    fontSize: 18.sp,
                  ),
                  CustomText(
                    text: "USD ${hourlyRate.toString()} /hr",
                    color: AppColors.blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () => CustomButton(
                  loading: _addTaskController.isBookLoading.value,
                  onTap: () {
                    _addTaskController.bookTask();
                  },
                  text: AppStrings.bookNow,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
