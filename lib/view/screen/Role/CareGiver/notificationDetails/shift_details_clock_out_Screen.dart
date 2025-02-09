import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../helpers/route.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/care_giver_app_bar.dart';
import '../../../../base/custom_button.dart';

class ShiftDetailsClockOutScreen extends StatefulWidget {
  const ShiftDetailsClockOutScreen({super.key});

  @override
  State<ShiftDetailsClockOutScreen> createState() =>
      _ShiftDetailsClockOutScreenState();
}

class _ShiftDetailsClockOutScreenState
    extends State<ShiftDetailsClockOutScreen> {
  final isSelected = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CareGiverAppBar(
        title: AppStrings.Details,
        icon: Icon(Icons.arrow_back_ios),
        onTap: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 20.sp,
                    width: 8.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      AppStrings.roomCleaning,
                      style: AppStyles.fontSize20(
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkGrayColor),
                    ),
                  ),
                ],
              ),
              Container(
                height: 1,
                color: AppColors.hintColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  AppStrings.shiftTask,
                  style: AppStyles.fontSize16(
                      fontWeight: FontWeight.w600, color: AppColors.hintColor),
                ),
              ),

              //======================== Shift Task List =============================
              InkWell(
                onTap: () {
                  // Get.toNamed(AppRoutes.serviceDetailsScreen);
                },
                child: Card(
                  color: AppColors.lightPurpleColor,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.roomCleaning,
                                style: AppStyles.fontSize18(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryColor),
                              ),
                              SizedBox(
                                width: 50.w,
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                child: SvgPicture.asset(
                                  AppIcons.threeDotVerticalIcon,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ],
                          ),

                          // ============================ yes no buttons ==========================

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () => Get.back(),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor:
                                          AppColors.lightGreenColor,
                                      foregroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        side: BorderSide(color: Colors.green),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.0),
                                      child: Text(
                                        AppStrings.yes,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16.w,
                                ),
                                Expanded(
                                  child: Obx(() => ElevatedButton(
                                        onPressed: () => Get.toNamed(
                                            AppRoutes.shiftDetailsNoScreen),
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor: isSelected.value
                                              ? Colors.red
                                              : Colors.redAccent.shade100,
                                          foregroundColor: isSelected.value
                                              ? Colors.white
                                              : Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.r),
                                            side: BorderSide(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Text(
                                            AppStrings.no,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Leave comment (ops)",
                      style: AppStyles.fontSize16(
                        color: AppColors.veryLightreenColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Leave a comment",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                              width: 1.0, color: AppColors.primaryColor),
                        ),
                      ),
                      minLines: 2,
                      maxLines: null,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How many mileage do you drive today(ops)",
                      style: AppStyles.fontSize16(
                        color: AppColors.veryLightreenColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "write here",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),

                          borderSide: const BorderSide(
                              width: 1.0, color: AppColors.primaryColor),
                        ),
                      ),
                      minLines: 2,

                      maxLines: null,
                    ),
                  ],
                ),
              ),

              //============================clock out button =========================
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: CustomButton(
                  textColor: AppColors.textColor,
                  onTap: () {
                    Get.toNamed(AppRoutes.workUnderReviewScreen);
                  },
                  text: AppStrings.clockOut.tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
