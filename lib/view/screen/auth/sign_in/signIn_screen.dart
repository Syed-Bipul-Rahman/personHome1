import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:home_health_app/helpers/route.dart';
import '../../../../controller/auth/auth_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/style.dart';
import '../../../base/borderless_custom_textField.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final authController = Get.put(AuthController());
  TextEditingController passCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.signIn,
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
      backgroundColor: AppColors.whiteColor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                // Text sections
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.signIntoContinue.tr,
                      style: AppStyles.fontSize18(color: AppColors.blackColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                BorderlessCustomTextField(
                    prefixIcon: SvgPicture.asset(AppIcons.emailIcon),
                    hintText: AppStrings.email.tr,
                    controller: authController.signInEmailCtrl),
                SizedBox(height: 16.h),
                BorderlessCustomTextField(
                    isPassword: true,
                    prefixIcon: SvgPicture.asset(AppIcons.lockIcon),
                    hintText: AppStrings.password.tr,
                    controller: authController.passCtrl),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //=================================> Forgot Password Button <================================
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.forgotPasswordScreen);
                      },
                      child: CustomText(
                        fontWeight: FontWeight.w600,
                        text: AppStrings.forgetPassword.tr,
                        color: AppColors.secondatyColor,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 250.h),

                ///=================================>>  Sing In Button <<=======================
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    textColor: AppColors.textColor,
                    onTap: () {
                      // if (_formKey.currentState!.validate()) {
                      //   // authController.signInMethod();
                      //
                      //   Get.toNamed(AppRoutes.userHomePageScreen);
                      //
                      // }
                      // Get.toNamed(AppRoutes.userHomePageScreen);

                      // role == AppStrings.caregiver
                      //     ? Get.toNamed(AppRoutes.careGiverHomeScreen)
                      //     : Get.toNamed(AppRoutes.userHomePageScreen);

                      authController.signInMethod();
                    },
                    text: AppStrings.signIn.tr,
                  ),
                ),

                ///==================>> Don't have and Account <===================
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: AppStrings.doNotHaveAccount.tr,
                      fontWeight: FontWeight.w400,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.signUpScreen);
                      },
                      child: CustomText(
                        fontWeight: FontWeight.w600,
                        text: AppStrings.signUpText.tr,
                        color: AppColors.secondatyColor,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
