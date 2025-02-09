import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_health_app/helpers/route.dart';
import 'package:home_health_app/utils/app_colors.dart';
import 'package:home_health_app/utils/app_icons.dart';
import 'package:home_health_app/utils/app_strings.dart';
import 'package:home_health_app/utils/style.dart';
import 'package:home_health_app/view/base/custom_button.dart';

class JoinAsScreen extends StatelessWidget {
  const JoinAsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {},
              child: Text(
                'Skip',
                style: AppStyles.fontSize14(color: AppColors.colorA1A8B0),
              ),
            ),
          ),
          // Main content centered
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(AppIcons.heartLogo),
                  SizedBox(height: 40.h),
                  Text(
                    'Welcome to \nBig Heart',
                    style: AppStyles.fontSize20(
                      fontWeight: FontWeight.w600,
                      color: AppColors.color193664,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Your health is our priority',
                    style: AppStyles.fontSize18(
                      fontWeight: FontWeight.w400,
                      color: AppColors.color193664,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 60.h,
            left: 20.w,
            right: 20.w,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppStrings.joinAs,
                    style: AppStyles.fontSize18(
                      fontWeight: FontWeight.w600,
                      color: AppColors.color333333,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                        onTap: () {
                          Get.toNamed(AppRoutes.signInScreen, arguments: {
                            'role': AppStrings.user,
                          });
                        },
                        text: AppStrings.user,
                        textStyle: AppStyles.fontSize16(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: CustomButton(
                        onTap: () {
                          Get.toNamed(AppRoutes.signInScreen, arguments: {
                            'role': AppStrings.caregiver,
                          });
                        },
                        color: Colors.white,
                        text: AppStrings.caregiver,
                        textStyle: AppStyles.fontSize16(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
