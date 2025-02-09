import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_health_app/controller/job/apply_job_controller.dart';

import '../../../../../helpers/route.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/Custom_text_field_with_border.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_dropdown.dart';
import '../../../../base/custom_text.dart';

class ApplyJobStepOneScreen extends StatefulWidget {
  const ApplyJobStepOneScreen({super.key});

  @override
  State<ApplyJobStepOneScreen> createState() => _ApplyJobStepOneScreenState();
}

class _ApplyJobStepOneScreenState extends State<ApplyJobStepOneScreen> {
  ApplyJobController applyJobController = Get.put(ApplyJobController());

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final jobId = arguments['jobId'];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.applyJob,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.w),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.stepOneOfThree,
                    style: AppStyles.fontSize16(
                      color: AppColors.veryLightreenColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              //======================== Full Name =============================

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.fullName,
                      style: AppStyles.fontSize16(
                        color: AppColors.veryLightreenColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomTextFieldWithBorder(
                      controller: applyJobController.fullNameCTRL,
                      hint: AppStrings.textFieldData,
                    ),
                  ],
                ),
              ),

              //======================== Email =============================

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.emailAddress,
                      style: AppStyles.fontSize16(
                        color: AppColors.veryLightreenColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomTextFieldWithBorder(
                      controller: applyJobController.emailCTRL,
                      hint: AppStrings.email,
                    ),
                  ],
                ),
              ),

              //======================== Phone Number =============================

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.phoneNumber,
                      style: AppStyles.fontSize16(
                        color: AppColors.veryLightreenColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomTextFieldWithBorder(
                      controller: applyJobController.phoneNumberCTRL,
                      hint: AppStrings.textFieldData,
                    ),
                  ],
                ),
              ),

              //=============================== Upload Picture =============================
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  AppStrings.uploadPicture,
                  style: AppStyles.fontSize16(
                    color: AppColors.veryLightreenColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.image,
                    allowMultiple: false,
                  );

                  if (result != null) {
                    applyJobController.imagePath?.value = result.files.single.path!;
                  }
                },
                child: Obx(() {
                  return Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                      image: applyJobController.imagePath?.value != null
                          ? DecorationImage(
                        image: FileImage(File(applyJobController.imagePath!.value)),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: applyJobController.imagePath?.value == null
                        ? Center(child: Icon(Icons.upload))
                        : null,
                  );
                }),
              ),

              //=============================== JOb Position =============================
              // Padding(
              //   padding: const EdgeInsets.only(top: 8.0),
              //   child: Text(
              //     AppStrings.jobPosition,
              //     style: AppStyles.fontSize16(
              //       color: AppColors.veryLightreenColor,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
              // CustomDropdown(
              //   items: applyJobController.items,
              //   hint: AppStrings.dropDownData,
              //   controller: applyJobController.jobPositionCTRL,
              //   onChanged: (String? value) {
              //     print("Selected Position: $value");
              //     setState(() {
              //       applyJobController.jobPositionCTRL.text = value!;
              //     });
              //   },
              // ),
              SizedBox(height: 8.h),
              CustomButton(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                onTap: () {
                  Get.toNamed(AppRoutes.applyJobStepTwoScreen, arguments: {
                    'jobId': jobId,
                  });
                },
                text: AppStrings.next.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
