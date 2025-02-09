import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_health_app/utils/app_images.dart';

import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/style.dart';
import '../../../base/custom_button.dart';

class WorkUnderReviewScreen extends StatelessWidget {
  const WorkUnderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 150,),
              Center(
                child: Column(
                  children: [
                    Text(
                      AppStrings.workUnderreveiw,
                      style: AppStyles.fontSize28(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor),
                    ),
                    Text(
                      AppStrings.thankyou,
                      style: AppStyles.fontSize16(
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkGrayColor),
                    ),
                    Image.asset(AppImages.questions),

                    SizedBox(height: 50,),

                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: CustomButton(
                        textColor: AppColors.textColor,
                        onTap: () {
                          Get.toNamed(AppRoutes.careGiverHomeScreen);
                        },
                        text: AppStrings.backToHomePage.tr,
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
