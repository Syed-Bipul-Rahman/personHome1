import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_health_app/helpers/route.dart';
import 'package:home_health_app/utils/app_images.dart';
import 'package:home_health_app/view/base/custom_button.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_text.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/ignore_steps.dart';
import 'package:another_xlider/models/slider_step.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:another_xlider/another_xlider.dart';

class MatchingDistanceScreen extends StatefulWidget {
  const MatchingDistanceScreen({super.key});

  @override
  State<MatchingDistanceScreen> createState() => _MatchingDistanceScreenState();
}

class _MatchingDistanceScreenState extends State<MatchingDistanceScreen> {
  double _lv1 = 10.0;
  double _uv1 = 15.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
            onTap: () {
              Get.toNamed(AppRoutes.caregiverListScreen, parameters: {
                "minRange": (_lv1 * 1000).toInt().toString(),
                "maxRange": (_uv1 * 1000).toInt().toString(),
              });
            },
            text: "Search"),
      ),
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.matching,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.w),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.greyColor),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppStrings.matchingDistance,
                      style: AppStyles.fontSize24(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),

            //======================== Distance Slider =============================
            _rangeSliderIgnoreSteps(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //========================> Minimum and Maximum Distance <==========================
                  Column(
                    children: [
                      Text(
                        AppStrings.minimum,
                        style: AppStyles.fontSize14(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 24.0),
                          child: Text(
                            "${_lv1.toInt()} Miles",
                            style: AppStyles.fontSize18(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        AppStrings.maximum,
                        style: AppStyles.fontSize14(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 24.0),
                          child: Text(
                            "${_uv1.toInt()} Miles",
                            style: AppStyles.fontSize18(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AppImages.matchingPageImage),
            ),
          ],
        ),
      ),
    );
  }

  _rangeSliderIgnoreSteps() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FlutterSlider(
                values: [_lv1, _uv1],
                rangeSlider: true,
                ignoreSteps: [
                  FlutterSliderIgnoreSteps(from: 8, to: 12),
                  FlutterSliderIgnoreSteps(from: 18, to: 22),
                ],
                max: 25,
                min: 0,
                step: const FlutterSliderStep(step: 1),
                jump: true,
                trackBar: const FlutterSliderTrackBar(
                  activeTrackBarHeight: 5,
                ),
                tooltip: FlutterSliderTooltip(
                  textStyle: TextStyle(fontSize: 17, color: Colors.lightBlue),
                ),
                handler: FlutterSliderHandler(
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
                rightHandler: FlutterSliderHandler(
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
                onDragging: (_handlerIndex, _lowerValue, _upperValue) {
                  setState(() {
                    _lv1 = _lowerValue;
                    _uv1 = _upperValue;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
