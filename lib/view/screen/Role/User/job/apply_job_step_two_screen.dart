import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_health_app/controller/job/apply_job_controller.dart';

import '../../../../../helpers/route.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/Custom_text_field_with_border.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_dropdown.dart';
import '../../../../base/custom_text.dart';
import '../../../../base/custom_text_field.dart';

class ApplyJobStepTwoScreen extends StatefulWidget {
  const ApplyJobStepTwoScreen({super.key});

  @override
  State<ApplyJobStepTwoScreen> createState() => _ApplyJobStepTwoScreen();
}

class _ApplyJobStepTwoScreen extends State<ApplyJobStepTwoScreen> {

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
                    AppStrings.stepTwoOfThree,
                    style: AppStyles.fontSize16(
                      color: AppColors.veryLightreenColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       AppStrings.experience,
              //       style: AppStyles.fontSize18(
              //         color: AppColors.veryLightreenColor,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //     Icon(Icons.add),
              //   ],
              // ),

              //======================== Company Name =============================

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Experience",
                      style: AppStyles.fontSize16(
                        color: AppColors.veryLightreenColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    CustomTextFieldWithBorder(
                      controller: applyJobController.experienceDegreeCTRL,
                      hint:"Experience",
                    ),
                  ],
                ),
              ),

              //======================== Job Title =============================
              //
              // Padding(
              //   padding: const EdgeInsets.only(top: 8.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         AppStrings.jobTitle,
              //
              //
              //         style: AppStyles.fontSize16(
              //           color: AppColors.veryLightreenColor,
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //       SizedBox(
              //         height: 8.h,
              //       ),
              //       CustomTextFieldWithBorder(
              //         controller: applyJobController.jobTitleCTRL,
              //         hint: AppStrings.textFieldData,
              //       ),
              //     ],
              //   ),
              // ),

              //======================== Duration =============================

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.duration,
                      style: AppStyles.fontSize16(
                        color: AppColors.veryLightreenColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    CustomTextFieldWithBorder(
                      controller: applyJobController.durationCTRL,
                      hint: AppStrings.textFieldData,
                    ),
                  ],
                ),
              ),

              //======================== Key Responsibilities =============================

              // Padding(
              //   padding: const EdgeInsets.only(top: 8.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         AppStrings.keyResponsibilities,
              //         style: AppStyles.fontSize16(
              //           color: AppColors.veryLightreenColor,
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //       SizedBox(
              //         height: 8.h,
              //       ),
              //       CustomTextFieldWithBorder(
              //         controller: applyJobController.keyResponsibilityCTRL,
              //         hint: AppStrings.textFieldData,
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 20.h,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       AppStrings.experience,
              //       style: AppStyles.fontSize18(
              //         color: AppColors.veryLightreenColor,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //     Icon(Icons.add),
              //   ],
              // ),
              //
              // //======================== Degree =============================
              //
              // Padding(
              //   padding: const EdgeInsets.only(top: 8.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         AppStrings.degreeCertificate,
              //         style: AppStyles.fontSize16(
              //           color: AppColors.veryLightreenColor,
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //       SizedBox(
              //         height: 8.h,
              //       ),
              //       CustomTextFieldWithBorder(
              //         controller: applyJobController.experienceDegreeCTRL,
              //         hint: AppStrings.textFieldData,
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.education,
                      style: AppStyles.fontSize16(
                        color: AppColors.veryLightreenColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    CustomTextFieldWithBorder(
                      controller: applyJobController.educationCTRL,
                      hint: AppStrings.textFieldData,
                    ),
                  ],
                ),
              ),
              //======================== Institutions =============================

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.institution,
                      style: AppStyles.fontSize16(
                        color: AppColors.veryLightreenColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    CustomTextFieldWithBorder(
                      controller: applyJobController.instituteCTRL,
                      hint: AppStrings.textFieldData,
                    ),
                  ],
                ),
              ),

              //=============================== Complete Year =============================
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  AppStrings.completeYear,
                  style: AppStyles.fontSize16(
                    color: AppColors.veryLightreenColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomDropdown(
                items: applyJobController.completeYearsItems,
                hint: AppStrings.textFieldData,
                controller: applyJobController.completeYearCTRL,
                onChanged: (String? value) {
                  print("Selected Year: $value");
                  setState(() {
                    applyJobController.completeYearCTRL.text = value!;
                  });
                },
              ),
              SizedBox(height: 8.h),
              CustomButton(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                onTap: () {
                  Get.toNamed(AppRoutes.applyJobStepThreeScreen,arguments: {
                    'jobId': jobId,
                  });
                },
                text: AppStrings.next.tr,
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}
