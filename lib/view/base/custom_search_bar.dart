import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../helpers/route.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import '../../utils/app_strings.dart';
import '../../utils/style.dart';

Widget CustomSearchBar() {
  final FocusNode _focusNode = FocusNode();
  TextEditingController _searchController = TextEditingController();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: 278.w,
        child: Material(
          elevation: 2,
          shadowColor: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8.r),
          child: TextField(
            controller: _searchController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              fillColor: AppColors.whiteColor,
              filled: true,
              hintStyle: AppStyles.fontSize18(color: AppColors.greyColor),
              hintText: AppStrings.searchWhatYouNeed.tr,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          // Get.toNamed(AppRoutes.userHomePageFilterScreen);
        },
        child: Container(
          height: 60.h,
          width: 60.w,
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: SvgPicture.asset(
              AppIcons.searchIcon,
              width: 24.w,
              height: 24.h,
            ),
          ),
        ),
      ),
    ],
  );
}