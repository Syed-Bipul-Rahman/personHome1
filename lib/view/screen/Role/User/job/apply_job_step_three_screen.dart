import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_health_app/controller/job/apply_job_controller.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_text.dart';

class ApplyJobStepThreeScreen extends StatefulWidget {
  const ApplyJobStepThreeScreen({super.key});

  @override
  State<ApplyJobStepThreeScreen> createState() => _ApplyJobStepThreeScreen();
}

class _ApplyJobStepThreeScreen extends State<ApplyJobStepThreeScreen> {
  ApplyJobController applyJobController = Get.put(ApplyJobController());

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      print("Selected PDF Path: ${result.files.single.path}");
      setState(() {
        applyJobController.resumeFileName?.value = result.files.single.name;
        applyJobController.resumeFilePath?.value = result.files.single.path ?? '';
      });
    } else {
      print("No PDF file selected");
      setState(() {
        applyJobController.resumeFileName?.value = "No file selected";
        applyJobController.resumeFilePath?.value = "No file chosen";
      });
    }
  }
    @override
  Widget build(BuildContext context) {

    final arguments = Get.arguments;
    final jobId = arguments['jobId'];
    applyJobController.jobPostId?.value = jobId;
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
                    AppStrings.stepThreeOfThree,
                    style: AppStyles.fontSize16(
                      color: AppColors.veryLightreenColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              //======================== Cover letter =============================

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.coverLetter,
                      style: AppStyles.fontSize16(
                        color: AppColors.veryLightreenColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: AppStrings.textFieldData,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                              width: 1.0, color: AppColors.primaryColor),
                        ),
                      ),
                      minLines: 6,
                      maxLines: null,
                      controller: applyJobController.coverLetterCTRL,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 8.h,
              ),
              //===================== Upload Resume ===============================
              Text(
                AppStrings.uploadResume,
                style: AppStyles.fontSize16(
                  color: AppColors.veryLightreenColor,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Container(
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 1.w,
                  ),
                ),
                child: InkWell(
                  onTap: _pickPDF,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          applyJobController.resumeFileName?.value ??
                              AppStrings.uploadResume,
                          style: AppStyles.fontSize16(
                            color: AppColors.veryLightreenColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(AppIcons.attachmentIcon),
                      ),
                    ],
                  ),
                ),
              ),

              //======================== Apply button =============================
              SizedBox(height: 20.h),
          Obx(
                () =>CustomButton(
                  loading: applyJobController.isLoading.value,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  onTap: () {
                    applyJobController.applyForJob();
                  },
                  text: AppStrings.apply.tr,
                ),),


            ],
          ),
        ),
      ),
    );
  }
}
