import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppStyles {


  static TextStyle onboardingScreen(
      {Color? color, FontWeight? fontWeight, double? letterSpacing}) {
    return TextStyle(
        color: color,
        fontSize: 68.sp,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w700);
  }
  static TextStyle onboardingScreenNormalText(
      {Color? color, FontWeight? fontWeight, double? letterSpacing}) {
    return TextStyle(
        color: color,
        fontSize: 48.sp,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }
  static TextStyle fontSize32(
      {Color? color, FontWeight? fontWeight, double? letterSpacing}) {
    return TextStyle(
        color: color,
        fontSize: 32.sp,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle fontSize28(
      {Color? color, FontWeight? fontWeight, double? letterSpacing}) {
    return TextStyle(
        color: color,
        fontSize: 28.sp,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }
  static TextStyle fontSize24(
      {Color? color, FontWeight? fontWeight, double? letterSpacing}) {
    return TextStyle(
        color: color,
        fontSize: 24.sp,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }



  static TextStyle fontSize20(
      {Color? color, FontWeight? fontWeight, double? letterSpacing}) {
    return TextStyle(
        color: color,
        fontSize: 20.sp,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle fontSize18({
    Color? color,
    FontWeight? fontWeight,
    double? letterSpacing,

  }) {
    return TextStyle(
        color: color,
        fontSize: 18.sp,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle fontSize16(
      {Color? color,
        FontWeight? fontWeight,
        double? letterSpacing,
        double? height}) {
    return TextStyle(
        fontSize: 16.sp,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle fontSize14(
      {Color? color,
        FontWeight? fontWeight,
        double? letterSpacing,
        double? height}) {
    return TextStyle(
        fontSize: 14.sp,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle fontSize12(
      {Color? color,
        FontWeight? fontWeight,
        double? letterSpacing,
        double? height}) {
    return TextStyle(
        fontSize: 12.sp,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle fontSize10(
      {Color? color,
        FontWeight? fontWeight,
        double? letterSpacing,
        double? height}) {
    return TextStyle(
        fontSize: 10.sp,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle customSize(
      {Color? color,
        required double size,
        String? family,
        double? letterSpacing,
        double? height,
        FontWeight? fontWeight}) {
    return TextStyle(
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color,
        fontSize: size,
        height: height,
        letterSpacing: letterSpacing,
       );
  }

  static BoxShadow boxShadow =  BoxShadow(
      blurRadius: 4,
      offset: const Offset(0,0),
      color:Color(0xFF292526).withOpacity(0.01),
      spreadRadius:0);

  static BoxShadow driverBoxShadow =  BoxShadow(
      blurRadius: 128,
      offset: const Offset(0,39),
      color:Color(0xFFEBEBEB),
      spreadRadius:0);
}