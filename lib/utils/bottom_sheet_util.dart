import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_health_app/helpers/prefs_helpers.dart';
import 'package:home_health_app/helpers/route.dart';

import 'app_colors.dart';
import 'app_strings.dart';

showLogoutBottomSheet() {
  Get.bottomSheet(
    Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            const Text(
              AppStrings.logOut,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 2,
              color: AppColors.hintColor,
            ),

            SizedBox(height: 16),
            // Description
            const Text(
              AppStrings.areYouSure,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Cancel Button
                ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.purple),
                    ),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
                    child: Text(
                      AppStrings.cancel,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                // Logout Button
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      PrefsHelper.remove(AppStrings.accessToken);
                      Get.offAllNamed(AppRoutes.signInScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                      child: Text(
                        AppStrings.yesLogOut,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    isDismissible: true,
  );
}
