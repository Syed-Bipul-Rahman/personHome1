import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_health_app/controller/care_giver_home_controller.dart';
import 'package:home_health_app/helpers/route.dart';
import 'package:home_health_app/utils/app_icons.dart';
import 'package:home_health_app/utils/app_strings.dart';

import '../../utils/app_colors.dart';
import '../../utils/style.dart';

class CareGiverAppBar extends StatelessWidget implements PreferredSizeWidget {
  final CareGiverHomeController controller = Get.put(CareGiverHomeController());

  final String? title;
  final VoidCallback? onTap;
  final Widget? icon;

  CareGiverAppBar({
    this.title,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title ?? controller.title.value,
        style: const TextStyle(color: Colors.black),
      ),
      leading: icon != null
          ? GestureDetector(
        onTap: onTap ?? () {},
        child: icon,
      )
          : IconButton(
        icon: const Icon(Icons.menu),
        onPressed: onTap ?? () => Scaffold.of(context).openDrawer(),
      ),
      actions: [
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.jobListScreen);
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
