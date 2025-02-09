import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_health_app/utils/app_colors.dart';
import 'package:home_health_app/utils/app_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/prefs_helpers.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // StreamSubscription;
    // getConnectivity();
    navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color98B3E142,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //=============================> Img Section <========================
                SvgPicture.asset(AppIcons.heartLogo),
                SizedBox(height: 12.h),
                SvgPicture.asset(AppIcons.bigHeartLogo),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///===================internet connection checker==================>

  navigateToNextScreen() {
    Timer(const Duration(seconds: 2), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? accessToken = prefs.getString(AppStrings.accessToken);
      final String? userRole = prefs.getString(AppStrings.userRole);
      final String? refreshToken = prefs.getString(AppStrings.refreshToken);
      print('Access Token==============>: $accessToken');
      print('Refresh Token=============>: $refreshToken');

      if (accessToken != null && refreshToken != null) {
        if (userRole == AppStrings.caregiver) {
          Get.offAllNamed(AppRoutes.careGiverHomeScreen);
        } else {
          Get.offAllNamed(AppRoutes.userHomePageScreen);
        }
      } else {
        Get.offAllNamed(AppRoutes.onboardingScreen);
      }
    });
  }

  ///========================is internet connection check========================>
// void getConnectivity() {
//   // streamSubscription =
//   Connectivity().onConnectivityChanged.listen((event) async {
//     // isConnection = await InternetConnectionChecker().hasConnection;
//     // isConnection = event != ConnectivityResult.none;
//     ///==================if internet is available===================>
//     if (isConnection) {
//       print("------------------Internet available");
//       Timer(const Duration(seconds: 4), () async {
//         bool? isLogged = await PrefsHelper.getBool(AppConstants.isLogged);
//         String token = await PrefsHelper.getString(AppConstants.bearerToken);
//         var role = await PrefsHelper.getString(AppConstants.role);
//
//         ///========================check islogged in, token, and role then decide where will be navigate====================>
//
//         if (isLogged != null && isLogged) {
//           if (token.isNotEmpty) {
//             if (role == Role.user.name) {
//               // Get.offAllNamed(AppRoutes.userHomeScreen);
//             }
//             if (role == Role.driver.name) {
//               //  Get.offAllNamed(AppRoutes.driverHomeScreen);
//             }
//           }
//         } else {
//           Get.offAllNamed(AppRoutes.onboardingScreen);
//         }
//       });
//     }
//
//     ///======================no internet=========================>
//     else {
//       Get.snackbar('Network Error!', 'Please connect your internet.');
//       // AppCustomToast.showCustomToast('Please connect your internet.');
//       print("----------------------No internet");
//     }
//   });
// }
}
