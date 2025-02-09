
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../../controller/settings/localization_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/style.dart';


class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final LocalizationController localizationController = Get.find<LocalizationController>();


  int? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          AppStrings.languageText.tr,
          style: TextStyle(color: AppColors.primaryColor,fontSize: 18.sp,),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.w),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: AppConstants.languages.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          var languageData = AppConstants.languages[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
            //leading: SvgPicture.asset(languageData.countryFlag,width: 30.w,height: 18.h,),
            title: Text(languageData.languageName,
              style: AppStyles.customSize(size: 16, color: AppColors.primaryColor),
            ),
            trailing: Radio<int>(
              value: index,
              groupValue: selectedOption,
              activeColor: AppColors.primaryColor,
              fillColor: MaterialStateProperty.all(AppColors.primaryColor),
              splashRadius: 25,
              onChanged: (int? value) {
                if (value != null) {
                  localizationController.setLanguage(
                      Locale(
                        AppConstants.languages[index].languageCode,
                        AppConstants.languages[index].countryCode,
                  ));
                  localizationController.setSelectIndex(value);
                  setState(() {
                    selectedOption = value;
                  });
                  Get.snackbar(
                    AppStrings.languageText.tr,
                    "${languageData.languageName}",
                    duration: Duration(seconds: 2),
                  );
                /* Future.delayed(Duration(seconds: 2), () {
                    Get.back();
                  });*/
                }
              },
            ),
          );
        },
      ),
    );
  }
}

