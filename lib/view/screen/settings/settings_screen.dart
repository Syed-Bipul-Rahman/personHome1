import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/style.dart';
import '../../base/custom_list_tile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          AppStrings.settings.tr,
          style: AppStyles.fontSize18(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.w),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //============================> Change Password List Tile <=================
                  CustomListTile(
                      onTap: () {
                        Get.toNamed(AppRoutes.changePasswordScreen);
                      },
                      title: AppStrings.changePasswordText.tr,
                      suffixIcon: Icon(Icons.arrow_forward_ios_rounded)),
                  SizedBox(height: 8.h),
                  //============================> Terms Services List Tile <=================
                  CustomListTile(
                      onTap: () {
                        Get.toNamed(AppRoutes.termsConditionScreen);
                      },
                      title: AppStrings.termsServicesText.tr,
                      suffixIcon: Icon(Icons.arrow_forward_ios_rounded)),
                  SizedBox(height: 8.h),
                  //============================> Privacy Policy List Tile <=================
                  CustomListTile(
                      onTap: () {
                        Get.toNamed(AppRoutes.privacyPolicyScreen);
                      },
                      title: AppStrings.privacyPolicy.tr,
                      suffixIcon: Icon(Icons.arrow_forward_ios_rounded)),
                  SizedBox(height: 8.h),
                  //============================> About Us List Tile <=================
                  CustomListTile(
                      onTap: () {
                        Get.toNamed(AppRoutes.aboutUsScreen);
                      },
                      title: AppStrings.aboutUsText.tr,
                      suffixIcon: Icon(Icons.arrow_forward_ios_rounded)),

                  SizedBox(height: 8.h),
                  //============================> Language Change List Tile <=================
                  CustomListTile(
                      onTap: () {
                        Get.toNamed(AppRoutes.helpAndSupportScreen);
                      },
                      title: AppStrings.helpAndSupport.tr,
                      suffixIcon: Icon(Icons.arrow_forward_ios_rounded)),
                  SizedBox(height: 8.h),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
