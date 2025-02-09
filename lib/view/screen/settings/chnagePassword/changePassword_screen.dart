import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../controller/auth/auth_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/style.dart';
import '../../../base/borderless_custom_textField.dart';
import '../../../base/custom_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final AuthController _authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          AppStrings.changePasswordText.tr,
          style: AppStyles.fontSize18(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //================>>> Old Password <<<===================
              SizedBox(height: 20.h),
              BorderlessCustomTextField(
                isPassword: true,
                prefixIcon: SvgPicture.asset(AppIcons.lockIcon),
                hintText: AppStrings.currentPasswordText.tr,
                controller: _authController.oldPassCtrl,
              ),

              //================>>> New Password <<<===================
              SizedBox(height: 20.h),
              BorderlessCustomTextField(
                isPassword: true,
                prefixIcon: SvgPicture.asset(AppIcons.lockIcon),
                hintText: AppStrings.newPasswordText.tr,
                controller: _authController.newPassCtrl,
              ),

              //================>>> Confirm Password <<<===================
              SizedBox(height: 20.h),
              BorderlessCustomTextField(
                  isPassword: true,
                  prefixIcon: SvgPicture.asset(AppIcons.lockIcon),
                  hintText: AppStrings.confrimNewPasswordText.tr,
                  controller: _authController.confirmPassCtrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Provide Confirm Password';
                    }
                    if (value != _authController.newPassCtrl.text) {
                      return "Password Not Match";
                    }
                    return null;
                  }),
              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _authController.changePasswordMethod();
                    }
                    ;
                  },
                  text: AppStrings.updatePasswordText.tr,
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
