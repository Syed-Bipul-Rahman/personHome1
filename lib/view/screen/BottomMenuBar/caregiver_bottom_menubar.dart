import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../helpers/route.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';

class CaregiverBottomNavigationBar extends StatelessWidget {
  final int menuIndex;

  const CaregiverBottomNavigationBar(this.menuIndex, {super.key});

  Color colorByIndex(ThemeData theme, int index) {
    return index == menuIndex ? AppColors.whiteColor : AppColors.blackColor;
  }

  BottomNavigationBarItem getItem(
      String image, String title, ThemeData theme, int index) {
    return BottomNavigationBarItem(
        label: title,
        icon: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: SvgPicture.asset(
            image,
            height: 24.0.h,
            width: 24.0.w,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<BottomNavigationBarItem> menuItems = [
      getItem(menuIndex == 0 ? AppIcons.myTaskFilledIcon : AppIcons.myTaskIcon, AppStrings.myTask.tr, theme, 0),
      getItem(menuIndex == 1 ? AppIcons.joblistFilledIcon : AppIcons.joblistIcon, AppStrings.jobList.tr, theme, 1),
      getItem(menuIndex == 2 ? AppIcons.messgeIconFillUp : AppIcons.messageIcon, AppStrings.message.tr, theme, 2),
      getItem(menuIndex == 3 ? AppIcons.hambergurIcon : AppIcons.hambergurIcon, AppStrings.menu.tr, theme, 3),
    ];

    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          boxShadow: [
            BoxShadow(
                color: Colors.black38,
                spreadRadius: 0,
                blurRadius: 10)
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.r), topLeft: Radius.circular(20.r)),
        child: BottomNavigationBar(
          backgroundColor: AppColors.primaryColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.whiteColor,
          unselectedItemColor: AppColors.whiteColor,
          currentIndex: menuIndex,
          onTap: (value) {
            switch (value) {
              case 0:
                Get.offAndToNamed(AppRoutes.careGiverHomeScreen);
                break;
              case 1:
                Get.offAndToNamed(AppRoutes.jobListScreen);
                break;
              case 2:
                Get.offAndToNamed(AppRoutes.messageScreen);
                break;
              case 3:
                Scaffold.of(context).openDrawer();
                break;
            }
          },
          items: menuItems,
        ),
      ),
    );
  }
}
