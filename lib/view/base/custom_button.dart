import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../utils/style.dart';
import 'custom_page_loading.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.color,
      this.borderColor,
      this.textColor,
      this.textStyle,
      this.padding = EdgeInsets.zero,
      required this.onTap,
      required this.text,
      this.loading = false,
      this.width,
      this.height});
  final Function() onTap;
  final String text;
  final bool loading;
  final double? height;
  final double? width;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
          onPressed: loading ? () {} : onTap,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.w, color: borderColor ?? AppColors.primaryColor),
                borderRadius: BorderRadius.circular(16.r)),
            backgroundColor: color ?? AppColors.primaryColor,
            minimumSize: Size(width ?? Get.width, height ?? 53.h),
          ),
          child: loading
              ? SizedBox(
                  height: 30.h,
                  width: 30.h,
                  child: CustomPageLoading(),
                )
              : Text(
                  text,
                  style: textStyle ??
                      AppStyles.fontSize18(
                          fontWeight: FontWeight.w500,
                          color: textColor ?? Colors.white),
                )),
    );
  }
}
