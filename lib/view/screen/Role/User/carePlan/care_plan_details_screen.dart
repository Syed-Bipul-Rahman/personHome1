import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_health_app/controller/booking/my_booking_controller.dart';
import 'package:home_health_app/view/base/cached_network_image.dart';
import 'package:home_health_app/view/base/custom_page_loading.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_list_button.dart';
import '../../../../base/custom_text.dart';

class CarePlanDetailsScreen extends StatefulWidget {
  const CarePlanDetailsScreen({super.key});

  @override
  State<CarePlanDetailsScreen> createState() => _CarePlanDetailsScreen();
}

class _CarePlanDetailsScreen extends State<CarePlanDetailsScreen> {
  final MyBookingController _myBookingController =
      Get.put(MyBookingController());
  late String bookingId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Safely retrieve bookingId from parameters
      bookingId = Get.parameters['booking'] ?? '';
      if (bookingId.isNotEmpty) {
        _myBookingController.fetchMyBookingDetails(bookingId);
      } else {
        print('Error: Booking ID is missing');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => CustomText(
              text: _myBookingController
                      .myBookingDetails.value.categoryId?.category ??
                  "No category",
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.w),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        final bookingDetails = _myBookingController.myBookingDetails.value;

        if (_myBookingController.isLoading.value) {
          return const Center(child: CustomPageLoading());
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Header Section
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: const BoxDecoration(
                            color: AppColors.lightOrange,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: SvgPicture.asset(
                              AppIcons.vacumeCleaner,
                              width: 50.w,
                              height: 50.h,
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bookingDetails.categoryId?.category ??
                                  "No category",
                              style: AppStyles.fontSize18(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8.sp),
                    Divider(color: Colors.grey),
                  ],
                ),

                // Status Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.status,
                        style: AppStyles.fontSize18(
                            color: AppColors.assColorColor,
                            fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp),
                            color: AppColors.lightGreenColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              bookingDetails.status ?? "Unknown",
                              style: AppStyles.fontSize16(
                                color: Colors.green,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.hintColor,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          AppIcons.calenderIcon,
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              AppStrings.eightToNineAM,
                              style: AppStyles.fontSize18(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              AppStrings.nineDec,
                              style: AppStyles.fontSize18(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Text(
                          AppStrings.scheduled,
                          style: AppStyles.fontSize16(
                              color: AppColors.assColorColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),

                // Caregiver Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          bookingDetails.status == "pending"
                              ? SizedBox()
                              : Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.hintColor,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        bookingDetails.acceptBy!.image['url'] !=
                                                null
                                            ? CustomNetworkImage(
                                                imageUrl: bookingDetails
                                                    .acceptBy!.image['url'],
                                                height: 40,
                                                width: 40)
                                            : SizedBox(),
                                  ),
                                ),
                          SizedBox(width: 20.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bookingDetails.acceptBy?.fullName?.isNotEmpty ==
                                        true
                                    ? bookingDetails.acceptBy!.firstName!
                                    : bookingDetails.user?.firstName ??
                                        "No user name",
                                style: AppStyles.fontSize18(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                AppStrings.caregiver,
                                style: AppStyles.fontSize16(
                                    color: AppColors.greyColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // InkWell(
                      //   onTap: (){
                      //
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(8.sp),
                      //       color: AppColors.primaryColor,
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           vertical: 8.0, horizontal: 16.0),
                      //       child: SvgPicture.asset(AppIcons.inboxIcon),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),

                // Service Tasks Section
                ListView.builder(
                  itemCount: bookingDetails.serviceTasks?.length ?? 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4),
                      child: CustomListButton(
                        label: bookingDetails.serviceTasks?[index].task ??
                            "No task",
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
