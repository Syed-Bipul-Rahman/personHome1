import 'package:flutter/material.dart';
import 'package:home_health_app/utils/app_colors.dart';


ThemeData light({Color color = const Color(0xFF039D55)}) => ThemeData(
      fontFamily: 'OpenSans',
      primaryColor: color,
      scaffoldBackgroundColor: Colors.transparent,
      secondaryHeaderColor: const Color(0xFF1ED7AA),
      disabledColor: const Color(0xFFBABFC4),
      brightness: Brightness.light,
      hintColor: const Color(0xFF9F9F9F),
      cardColor: Colors.white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.bottomBarColor,
        elevation: 5,
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: color)),
      colorScheme: ColorScheme.light(primary: color, secondary: color)
          .copyWith(background: const Color(0xFFF3F3F3))
          .copyWith(error: Color(0xFFE84D4F)),
    );
