import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_health_app/controller/job/job_list_controller.dart';
import 'package:home_health_app/view/base/custom_page_loading.dart';

import '../../../../../helpers/route.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/care_giver_app_bar.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_list_button.dart';

class NotificationDetailsScreen extends StatefulWidget {
  const NotificationDetailsScreen({super.key});

  @override
  State<NotificationDetailsScreen> createState() => _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  final JobListController _jobListController = Get.put(JobListController());

  @override
  void initState() {
    _jobListController.notificationId.value = Get.parameters['notificationId']!;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _jobListController.getSingleNotification();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CareGiverAppBar(
        title: AppStrings.Details,
        onTap: () {
          Get.back();
        },
      ),
      body: Obx(
        () => _jobListController.isSingleNotificationLoading.value
            ? Center(
                child: const CustomPageLoading(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        color: AppColors.lightPurpleColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  _jobListController.singleBookingDetails.value
                                      .bookingId!.categoryId!.category
                                      .toString(),
                                  style: AppStyles.fontSize18(
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.lightGreenColor,
                                        borderRadius:
                                            BorderRadius.circular(8.sp),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          _jobListController
                                                  .singleBookingDetails
                                                  .value
                                                  .bookingId!
                                                  .subcategoryId!
                                                  .hourRate
                                                  .toString() +
                                              ' /hr',
                                          style: AppStyles.fontSize16(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.darkGrayColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.access_time),
                                      Text(
                                        AppStrings.eightToNineAM,
                                        style: AppStyles.fontSize16(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.darkGrayColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  height: 1,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _jobListController.singleBookingDetails.value
                                      .bookingId!.description
                                      .toString(),
                                  style: AppStyles.fontSize16(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkGrayColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Total Task",
                              style: AppStyles.fontSize18(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              _jobListController.singleBookingDetails.value
                                  .bookingId!.serviceTasks!.length
                                  .toString(),
                              style: AppStyles.fontSize18(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor),
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                        itemCount: _jobListController.singleBookingDetails.value
                            .bookingId!.serviceTasks!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: CustomListButton(
                              label: _jobListController.singleBookingDetails
                                  .value.bookingId!.serviceTasks![index].task
                                  .toString(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 8.sp),
                      Container(
                        height: 200.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target:
                                LatLng(37.42796133580664, -122.085749655962),
                            zoom: 20,
                          ),
                          markers: {
                            Marker(
                              markerId: MarkerId('1'),
                              position:
                                  LatLng(37.42796133580664, -122.085749655962),
                            )
                          },
                        ),
                      ),
                      SizedBox(height: 8.sp),
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
                          const SizedBox(width: 8),
                          Text(
                            "${_jobListController.singleBookingDetails.value.bookingId!.user!.firstName}\'s Info",
                            style: AppStyles.fontSize20(
                                fontWeight: FontWeight.w700,
                                color: AppColors.darkGrayColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.sp),
                      Row(
                        children: [
                          const Icon(Icons.home_outlined),
                          const SizedBox(width: 8),
                          Text(
                            "${_jobListController.singleBookingDetails.value.bookingId!.user!.firstName}\'s Home",
                            style: AppStyles.fontSize20(
                                fontWeight: FontWeight.w700,
                                color: AppColors.darkGrayColor),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Text(
                          AppStrings.exampleLocation,
                          style: AppStyles.fontSize14(
                              fontWeight: FontWeight.w500,
                              color: AppColors.hintColor),
                        ),
                      ),
                      SizedBox(height: 8.sp),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Text(
                          AppStrings.navigateToAddress,
                          style: AppStyles.fontSize16(
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor),
                        ),
                      ),
                      SizedBox(height: 8.sp),
                      Container(
                        height: 2,
                        color: AppColors.hintColor,
                      ),
                      SizedBox(height: 8.sp),
                      Row(
                        children: [
                          const Icon(Icons.call_rounded),
                          const SizedBox(width: 8),
                          Text(
                            AppStrings.lanasHomePhone,
                            style: AppStyles.fontSize20(
                                fontWeight: FontWeight.w700,
                                color: AppColors.darkGrayColor),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Text(
                          "${_jobListController.singleBookingDetails.value.bookingId!.user!.email}",
                          style: AppStyles.fontSize14(
                              fontWeight: FontWeight.w500,
                              color: AppColors.hintColor),
                        ),
                      ),
                      SizedBox(height: 8.sp),
                      Container(
                        height: 2,
                        color: AppColors.hintColor,
                      ),
                      SizedBox(height: 24.sp),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColors.primaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Colors.grey.shade200,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                              ),
                              onPressed: () {
                                _jobListController.cancelBooking();
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.sp),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                              ),
                              onPressed: () {
                              _jobListController.acceptBooking();
                              },
                              child: Text(
                                'Accept',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.sp),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
