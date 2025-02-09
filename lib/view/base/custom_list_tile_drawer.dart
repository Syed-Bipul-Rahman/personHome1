import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_health_app/utils/app_colors.dart';

class CustomListTileDrawer extends StatelessWidget {
  final String? icon;
  final IconData? iconName;
  final String text;
  final VoidCallback onTap;

  const CustomListTileDrawer({
    Key? key,
    this.icon,
    this.iconName,
    required this.text,
    required this.onTap,
  })  : assert(icon != null || iconName != null,
            'Provide either icon or iconName'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor.withAlpha(25),
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildIcon(),
          ),
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            color: AppColors.whiteColor,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildIcon() {
    if (icon != null) {
      return SvgPicture.asset(
        icon!,
        color: AppColors.primaryColor,
      );
    } else if (iconName != null) {
      return Icon(
        iconName,
        color: AppColors.primaryColor,
        size: 24.0,
      );
    }
    return const SizedBox();
  }
}
