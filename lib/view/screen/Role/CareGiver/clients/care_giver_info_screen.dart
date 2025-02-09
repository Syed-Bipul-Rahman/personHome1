import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_health_app/utils/app_strings.dart';
import 'package:home_health_app/view/base/custom_app_bar.dart';

import '../../../../../helpers/route.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/style.dart';
import '../../../../base/care_giver_app_bar.dart';
import '../../../../base/custom_tab_widget.dart';
import 'care_giver_user_address_info.dart';

class CareGiverInfoScreen extends StatefulWidget {
  const CareGiverInfoScreen({super.key});

  @override
  State<CareGiverInfoScreen> createState() => _CareGiverInfoScreenState();
}

class _CareGiverInfoScreenState extends State<CareGiverInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CareGiverAppBar(
        title: AppStrings.userName,
        icon: Icon(Icons.arrow_back_ios),
        onTap: () {
          Get.back();
        },
      ),
      backgroundColor: AppColors.whiteColor,
      body: CustomTabWidget(
        tabs: ['User', 'Shift', 'SOS Contact'],
        tabContents: [
          // CareGiverUserAddressInfo(),

          Center(
            child: Text("joy bangla"),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.shiftDetailsScreen);
                  },
                  child: Card(
                    color: AppColors.lightPurpleColor,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              AppImages.subCategoryImageOne,
                              height: 120.h,
                              width: 120.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.roomCleaning,
                                style: AppStyles.fontSize18(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkGrayColor),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 16,
                                    width: 16,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.orangeAccentColor,
                                    ),
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    AppStrings.inProgress,
                                    style: AppStyles.fontSize14(
                                        color: AppColors.darkGrayColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  const Icon(Icons.access_time),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    AppStrings.eightToNineAM,
                                    style: AppStyles.fontSize14(
                                        color: AppColors.darkGrayColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  const Icon(Icons.map_outlined),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    AppStrings.exampleLocation,
                                    style: AppStyles.fontSize14(
                                        color: AppColors.hintColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.call_rounded),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        AppStrings.lanasHomePhone,
                        style: AppStyles.fontSize20(
                            fontWeight: FontWeight.w700,
                            color: AppColors.darkGrayColor),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    AppStrings.dummyPhoneNumber,
                    style: AppStyles.fontSize14(
                        fontWeight: FontWeight.w500,
                        color: AppColors.hintColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Column(
      //   children: [
      //
      //     CareGiverUserAddressInfo(),
      //   ],
      // ),
    );
  }
}
