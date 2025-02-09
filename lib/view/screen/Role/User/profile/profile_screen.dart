import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_health_app/service/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../controller/settings/profileInfoController.dart';
import '../../../../../helpers/route.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/bottom_sheet_util.dart';
import '../../../../../utils/style.dart';
import '../../../BottomMenuBar/user_bottom_menu.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileInfoController _profileInfoController = Get.put(ProfileInfoController());
  var userid = '';

  @override
  void initState() {
    super.initState();
    initializeUserId();
  }

  void initializeUserId() async {
    await getUserId();
    _profileInfoController.userId.value = userid;
    _profileInfoController.getMyInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const UserBottomNavigationBar(3),
      backgroundColor: Colors.white,
      body: Obx(
            () {
          if (_profileInfoController.isProfileLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Container(
                      height: 20.sp,
                      width: 8.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp),
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppStrings.profile,
                        style: AppStyles.fontSize20(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.hintColor,
                          width: 1.0,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundImage: _profileInfoController.userInfo.value.image?.url != null
                            ? NetworkImage(ApiConstants.baseUrl + _profileInfoController.userInfo.value.image!.url)
                            :  AssetImage(AppImages.placeholder) as ImageProvider,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _profileInfoController.userInfo.value.firstName ?? "No Name",
                          style: AppStyles.fontSize20(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          _profileInfoController.userInfo.value.email ?? "No Email",
                          style: AppStyles.fontSize16(
                              color: AppColors.greyColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      _buildListTile(Icons.person, AppStrings.personalInformation,
                          AppColors.darkGrayColor, () {
                            Get.toNamed(AppRoutes.personalInformationScreen);
                          }),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      _buildListTile(
                          Icons.link, 'Matching', AppColors.darkGrayColor, () {
                        Get.toNamed(AppRoutes.matchingDistanceScreen);
                      }),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      _buildListTile(
                          Icons.settings, 'Settings', AppColors.darkGrayColor, () {
                        Get.toNamed(AppRoutes.settingScreen);
                      }),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      _buildListTile(
                          Icons.exit_to_app, 'Logout', AppColors.redColor, () {
                        showLogoutBottomSheet();
                      }),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ListTile _buildListTile(
      IconData icon, String title, Color titleColor, Function onTap) {
    return ListTile(
      leading: Icon(icon, color: titleColor),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () => onTap(),
    );
  }

  Future<String?> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userid = preferences.getString(AppStrings.userId) ?? '';
    });
    return userid;
  }
}
