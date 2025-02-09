import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../helpers/route.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/borderless_custom_textField.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_text.dart';

class CardDetailsScreen extends StatefulWidget {
  const CardDetailsScreen({super.key});

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  TextEditingController cardHolderNameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.cardDetails,
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
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.h),
              // Text sections
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.cardHolderName.tr,
                    style: AppStyles.fontSize20(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              BorderlessCustomTextField(
                  hintText: AppStrings.cardNumber.tr,
                  controller: cardHolderNameCtrl),
              SizedBox(height: 16.h),
              // Text sections
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.cardNumber.tr,
                    style: AppStyles.fontSize20(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              BorderlessCustomTextField(
                  hintText: AppStrings.cardHolderName.tr,
                  controller: cardHolderNameCtrl),

              SizedBox(height: 16.h),
              // Text sections
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.cardNumber.tr,
                    style: AppStyles.fontSize20(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              BorderlessCustomTextField(
                  hintText: AppStrings.expiryDate.tr,
                  controller: cardHolderNameCtrl),
              SizedBox(height: 16.h),
              // Text sections
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.cvv.tr,
                    style: AppStyles.fontSize20(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              BorderlessCustomTextField(
                  hintText: AppStrings.cvv.tr, controller: cardHolderNameCtrl),

              SizedBox(height: 30.h),

              CustomButton(
                textColor: AppColors.textColor,
                onTap: () {
                  // Get.toNamed(AppRoutes.userHomePageScreen);
                },
                text: AppStrings.continueText.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
