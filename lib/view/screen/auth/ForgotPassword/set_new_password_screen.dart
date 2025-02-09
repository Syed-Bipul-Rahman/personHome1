import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../controller/auth/auth_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/style.dart';
import '../../../base/borderless_custom_textField.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';

class SetNewPasswordScreen extends StatelessWidget {
  SetNewPasswordScreen({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    authController.verifyEmail.value = arguments[AppStrings.email];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.setNewPassword,
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              AppStrings.setNewPassword.tr,
              style: AppStyles.fontSize16(color: AppColors.blackColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            BorderlessCustomTextField(
                prefixIcon: SvgPicture.asset(AppIcons.emailIcon),
                hintText: AppStrings.password.tr,
                controller: authController.setNewPass),
            SizedBox(height: 16.h),
            BorderlessCustomTextField(
                isPassword: true,
                prefixIcon: SvgPicture.asset(AppIcons.lockIcon),
                hintText: AppStrings.confrimNewPasswordText.tr,
                controller: authController.setNewPass),
            SizedBox(height: 50.h),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                textColor: AppColors.textColor,
                onTap: () {
                   authController.setNewPasswordMethod();


                },
                text: AppStrings.resetPasswordText.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
