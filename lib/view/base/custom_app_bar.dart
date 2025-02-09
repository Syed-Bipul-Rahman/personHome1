import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_health_app/utils/app_icons.dart';

import '../../helpers/route.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      leadingWidth: 120,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 8),
          Container(
            height: 50,
            width: 50,
            child: SvgPicture.asset(
              AppIcons.heartLogo,
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(width: 0),
          Container(
            height: 50,
            width: 50,
            child: SvgPicture.asset(
              AppIcons.bigHeartLogo,
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
      actions: [
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.notificationScreen);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SizedBox(
              height: 40,
              width: 40,
              child: SvgPicture.asset(
                AppIcons.bellNotificationIcon,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
