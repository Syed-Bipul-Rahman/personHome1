import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';


ThemeData dark({Color color = const Color(0xFF2683EB)}) => ThemeData(
  fontFamily: 'OpenSans',
  primaryColor: color,
  scaffoldBackgroundColor:AppColors.blackColor,
  secondaryHeaderColor:  color.withOpacity(0.4),
  disabledColor:AppColors.subTextColor,
  brightness: Brightness.dark,
  hintColor:AppColors.hintColor,
  cardColor:AppColors.cardColor,
  dividerColor: AppColors.dividerColor,
  shadowColor: AppColors.shadowColor,
  canvasColor: AppColors.bottomBarColor,

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.fillColor,
    hintStyle: TextStyle(color:AppColors.hintColor,fontSize:16.sp),
    isDense: true,
    contentPadding:EdgeInsets.symmetric(
      horizontal:12.w,
      vertical: 16.h
    ),
    enabledBorder: enableBorder(),
    focusedBorder: focusedBorder(),
    errorBorder:errorBorder()

  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    backgroundColor:AppColors.bottomBarColor,
    selectedLabelStyle: TextStyle(color:color),
    unselectedLabelStyle: TextStyle(color:AppColors.subTextColor),
  ),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: color)), colorScheme: ColorScheme.dark(primary: color, secondary: color).copyWith(background: const Color(0xFF343636)).copyWith(error: const Color(0xFFdd3135)),
);

OutlineInputBorder enableBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide.none,
  );
}
OutlineInputBorder focusedBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide:BorderSide(
      color: AppColors.primaryColor,
    ),
  );
}

OutlineInputBorder errorBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide:const BorderSide(
      color: Colors.red,
    ),
  );
}