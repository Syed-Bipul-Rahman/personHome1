import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../controller/settings/privacy_policy_controller.dart';
import '../../../../controller/settings/settings_controller.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_loading.dart';
import '../../../base/custom_page_loading.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({super.key});

  final SettingsController settingsController = Get.put(SettingsController());
  final PrivacyPolicyController privacyPolicyController =
      Get.put(PrivacyPolicyController());

  @override
  Widget build(BuildContext context) {
    // settingsController.getAboutUs();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: Text(
          AppStrings.aboutUsText.tr,
          style: TextStyle(fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (privacyPolicyController.isLoading.value) {
                return const Center(
                  child: CustomPageLoading(),
                );
              }
              return Html(
                data: privacyPolicyController.aboutUsText.value,
              );
            }),
          ],
        ),
      ),
    );
  }
}
