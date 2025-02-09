import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_health_app/Utils/app_constants.dart';
import 'package:home_health_app/helpers/prefs_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/care_giver_home_controller.dart';
import '../../helpers/route.dart';
import '../../service/api_constants.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';
import '../../utils/style.dart';
import 'custom_list_tile_drawer.dart';

class CustomNavigationDrawer extends StatefulWidget {
  CustomNavigationDrawer({Key? key}) : super(key: key);

  @override
  State<CustomNavigationDrawer> createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
  final CareGiverHomeController controller = Get.put(CareGiverHomeController());
  var imageurl = '';
  var name = '';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final fetchedImageUrl =
    await PrefsHelper.getString(AppConstants.caregiverImageUrl);
    final fetchedName =
    await PrefsHelper.getString(AppConstants.caregiverName);

    setState(() {
      imageurl = fetchedImageUrl ?? '';
      name = fetchedName ?? '';
    });
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.purpleColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 35.0),

            //============================= User Profile ==============================
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.caregiverProfileScreen);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withAlpha(25),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.r),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:Row(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: imageurl.isNotEmpty
                            ? NetworkImage(ApiConstants.baseUrl + imageurl) as ImageProvider
                            : AssetImage(AppImages.appLogo) as ImageProvider,
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name.isNotEmpty ? name : "Unknown",
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
                    ],
                  ),
                ),
              ),
            ),

            //=================================> Shift  <================================
            const SizedBox(height: 16.0),
            CustomListTileDrawer(
              icon: AppIcons.calenderIcon,
              text: AppStrings.homess,
              onTap: () {
                controller.title.value = AppStrings.homess;
                if (Get.currentRoute == AppRoutes.careGiverHomeScreen) {
                  Get.back();
                } else {
                  Get.toNamed(AppRoutes.careGiverHomeScreen);
                }
              },
            ),

            //=================================> Clients  <================================
            const SizedBox(height: 16.0),
            CustomListTileDrawer(
              iconName: Icons.wallet,
              text: AppStrings.wallet,
              onTap: () {
                controller.title.value = "Wallet";
                if (Get.currentRoute == AppRoutes.caregiverWalletScreen) {
                  Get.back();
                } else {
                  Get.toNamed(AppRoutes.caregiverWalletScreen);
                }
              },
            ),

            //=================================> Training  <================================
            const SizedBox(height: 60.0),
            CustomListTileDrawer(
              iconName: Icons.shopping_bag_outlined,
              text: AppStrings.training,
              onTap: () {
                controller.title.value = AppStrings.training;
                if (Get.currentRoute == AppRoutes.careGiverTrainingScreen) {
                  Get.back();
                } else {
                  Get.toNamed(AppRoutes.careGiverTrainingScreen);
                }
              },
            ),

            //=================================> Tutorials  <================================
            const SizedBox(height: 16.0),
            CustomListTileDrawer(
              icon: AppIcons.calenderIcon,
              text: AppStrings.tutorial,
              onTap: () {
                controller.title.value = AppStrings.tutorial;
                if (Get.currentRoute == AppRoutes.careGiverTutorialScreen) {
                  Get.back();
                } else {
                  Get.toNamed(AppRoutes.careGiverTutorialScreen);
                }
              },
            ),
            //=================================> settings  <================================
            const SizedBox(height: 16.0),
            CustomListTileDrawer(
              icon: AppIcons.calenderIcon,
              text: AppStrings.settings,
              onTap: () {
                controller.title.value = AppStrings.settings;
                if (Get.currentRoute == AppRoutes.settingScreen) {
                  Get.back();
                } else {
                  Get.toNamed(AppRoutes.settingScreen);
                }
              },
            ),

            //=================================> Log out  <================================
            const SizedBox(height: 16.0),
            CustomListTileDrawer(
              icon: AppIcons.calenderIcon,
              text: AppStrings.logOut,
              onTap: () {
                showLogoutBottomSheet();
              },
            ),
          ],
        ),
      ),
    );
  }

  //============================  Logout Bottom Sheet ============================
  showLogoutBottomSheet() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              const Text(
                AppStrings.logOut,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 2,
                color: AppColors.hintColor,
              ),

              SizedBox(height: 16),
              // Description
              const Text(
                AppStrings.areYouSure,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel Button
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.purple),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
                      child: Text(
                        AppStrings.cancel,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  // Logout Button
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        PrefsHelper.remove(AppStrings.accessToken);
                        Get.offAllNamed(AppRoutes.signInScreen);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12),
                        child: Text(
                          AppStrings.yesLogOut,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      isDismissible: true,
    );
  }
}
