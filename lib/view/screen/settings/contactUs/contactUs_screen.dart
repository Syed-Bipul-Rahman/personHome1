import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controller/settings/settings_controller.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_loading.dart';


class ContactUsScreen extends StatelessWidget {
   ContactUsScreen({super.key});

  final SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    // settingsController.getContactUs();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        appBar: AppBar(
          title: Text(AppStrings.contactUsText.tr,
            style: TextStyle(fontSize: 18.sp),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Obx(
              () => settingsController.isContactUsLoading.value
              ? const CustomLoading()
              : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                children: [
                  //===========================> Text Section <=====================
                  Obx(() => Html(
                    shrinkWrap: true,
                    data: settingsController.contactUsLoadingContent.value,
                  )),
                ],
              ),
            ),
          ),
        )
    );
  }
}