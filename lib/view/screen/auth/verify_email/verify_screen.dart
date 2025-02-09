import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:home_health_app/utils/app_colors.dart';
import 'package:home_health_app/utils/app_strings.dart';
import 'package:home_health_app/utils/style.dart';

import '../../../../controller/auth/auth_controller.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';
import '../../../base/pin_code_text_field.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  AuthController authController = Get.put(AuthController());



  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
     authController.verifyEmail.value = arguments[AppStrings.email];
    final screenType = arguments[AppStrings.screenType];
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.verifyEmail,
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            Text(
              AppStrings.weHaveSentAnVerificationCode.tr,
              style: AppStyles.fontSize16(color: AppColors.blackColor),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 30.h),
            CustomPinCodeTextField(
                textEditingController: authController.pinCodeCtrl,
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: AppStrings.didnotGetTheCode.tr,
                ),
                //=====================> Resend Text Button <=================
                InkWell(
                  onTap: () {
                    // authController.resendOtp();
                  },
                  child: CustomText(
                    text: AppStrings.resend.tr,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onTap: () {
                    authController.verifyEmailMethod(screenType);

                },
                text: AppStrings.verifyEmail.tr,
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
