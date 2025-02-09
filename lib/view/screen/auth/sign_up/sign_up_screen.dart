import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:home_health_app/utils/app_icons.dart';
import 'package:home_health_app/utils/app_strings.dart';
import 'package:home_health_app/view/base/borderless_custom_textField.dart';
import 'package:home_health_app/view/base/custom_button.dart';
import 'package:home_health_app/view/base/custom_text.dart';

import '../../../../controller/auth/auth_controller.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthController authController = Get.put(AuthController());

  bool isChecked = false;
  bool isCheckboxError = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //=============================> AppBar Section <=======================
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.signUpText,
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
      //=============================> Body Section <=========================
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: AppStrings.signUpToJoinText,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                bottom: 21.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    //========================> First Name Text Field <==========================
                    BorderlessCustomTextField(
                        hintText: 'First Name',
                        prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(AppIcons.profileIcon)),
                        controller: authController.firstNameCtrl),
                    SizedBox(height: 16.h),
                    //========================> Last Name Text Field <==========================
                    BorderlessCustomTextField(
                        hintText: 'Last Name',
                        prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(AppIcons.profileIcon)),
                        controller: authController.lastNameCtrl),
                    SizedBox(height: 16.h),
                    //========================> Email Text Field <==========================
                    BorderlessCustomTextField(
                        hintText: 'Email',
                        prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(AppIcons.emailIcon)),
                        controller: authController.emailCtrl),
                    SizedBox(height: 16.h),
                    //========================> Password Text Field <==========================
                    BorderlessCustomTextField(
                        hintText: 'Password',
                        isPassword: true,
                        prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(AppIcons.lockIcon)),
                        controller: authController.passwordCtrl),
                    SizedBox(height: 16.h),
                    //========================> Confirm Password Text Field <==========================
                    BorderlessCustomTextField(
                        isPassword: true,
                        hintText: 'Password',
                        prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(AppIcons.lockIcon)),
                        controller: authController.confirmPasswordCtrl),
                    //========================> Checkbox Section <==========================
                    SizedBox(height: 16.h),
                    _checkboxSection(),
                    //========================> Sign Up Button <==========================
                    SizedBox(height: 32.h),
                    CustomButton(
                      onTap: () {
                        authController.signUpMethod();
                      },
                      text: AppStrings.signUpText,
                    ),
                    SizedBox(height: 10.h),

                    ///=================>>>>> Have Account Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: AppStrings.alreadyHaveAccount.tr,
                          fontWeight: FontWeight.w400,
                        ),
                        TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.signInScreen, arguments: {
                                'role': authController.role.value,
                              });
                            },
                            child: CustomText(
                              text: AppStrings.signIn.tr,
                              color: AppColors.secondatyColor,
                              fontWeight: FontWeight.w600,
                            ))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//==========================> Checkbox Section Widget <=======================
  _checkboxSection() {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: AppColors.primaryColor,
          focusColor: AppColors.greyColor,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
          side: BorderSide(
            color: isChecked ? AppColors.primaryColor : AppColors.primaryColor,
            width: 1.w,
          ),
        ),
        Text.rich(
          maxLines: 2,
          TextSpan(
            text: 'By creating an account, I accept \nthe ',
            style: TextStyle(fontSize: 14.w, fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: 'Terms & Conditions',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    //Get.toNamed(AppRoutes.termsConditionScreen);
                  },
              ),
              const TextSpan(text: ' & '),
              TextSpan(
                text: 'Privacy Policy.',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    //Get.toNamed(AppRoutes.privacyPolicyScreen);
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
