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
import '../../../base/custom_text.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController forgetEmailTextCtrl= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.forgetPassword,
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
              AppStrings.pleaseEnter.tr,
              style: AppStyles.fontSize16(color: AppColors.blackColor),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20.h),
            Form(
              key: _formKey,
              child: BorderlessCustomTextField(
                prefixIcon: SvgPicture.asset(AppIcons.emailIcon),
                hintText: AppStrings.email.tr,
                controller:forgetEmailTextCtrl,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  return null;
                },
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      authController.forgotEmail.value=forgetEmailTextCtrl.text;
                      authController.forgotPasswordMethod();
                    }
                  },
                  text: AppStrings.sendOTP.tr,
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
