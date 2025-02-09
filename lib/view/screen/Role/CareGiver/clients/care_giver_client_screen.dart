import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_health_app/view/base/custom_app_bar.dart';
import 'package:home_health_app/view/base/custom_drawer.dart';

import '../../../../../controller/care_giver_home_controller.dart';
import '../../../../../helpers/route.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/care_giver_app_bar.dart';
import '../../../../base/custom_list_tile_drawer.dart';

class CareGiverClientScreen extends StatefulWidget {
  const CareGiverClientScreen({super.key});

  @override
  State<CareGiverClientScreen> createState() => _CareGiverClientScreenState();
}

class _CareGiverClientScreenState extends State<CareGiverClientScreen> {
  final CareGiverHomeController controller = Get.put(CareGiverHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CareGiverAppBar(),
      //================================ Drawer Side bar =================================
      drawer: CustomNavigationDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.careGiverInfoScreen);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.r),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage(AppImages.userTwoImage),
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.userName,
                            style: AppStyles.fontSize18(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            AppStrings.caregiver,
                            style: AppStyles.fontSize16(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          // Get.toNamed(AppRoute.careGiverProfile);
                        },
                        icon: Icon(
                          Icons.navigate_next,size: 30.sp,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
