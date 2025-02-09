import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:home_health_app/helpers/route.dart';
import 'package:home_health_app/view/base/custom_page_loading.dart';
import 'package:home_health_app/view/screen/Role/CareGiver/booking/widgets/countdown_timer.dart';

import '../../../../../controller/work_controller.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/care_giver_app_bar.dart';
import '../../../../base/custom_list_button.dart';
import 'booking_details_controller.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final SingleBookingController _singleBookingController = Get.put(SingleBookingController());
  final WorkController _workController = Get.put(WorkController());

  @override
  void initState() {
    _singleBookingController.bookingId.value = Get.parameters['bookingId']!;
    _workController.bookingId.value = Get.parameters['bookingId']!;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _singleBookingController.getSingleBooking();
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
            () => _singleBookingController.isSingleNotificationLoading.value
            ? const Center(
          child: CustomPageLoading(),
        )
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Conditionally show CountUpTimerCard based on hasStartedWork
                if (_workController.hasStartedWork.value &&
                    (_singleBookingController.singleBookingDetails.value.status == 'accepted' ||
                        _singleBookingController.singleBookingDetails.value.status == "in-Progress"))
                  Column(
                    children: [
                      CountUpTimerCard(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                ),
                                onPressed: () {
                                  Get.toNamed(
                                      AppRoutes.requestPaymentScreen,
                                      parameters: {
                                        'hourlyRate': _singleBookingController
                                            .singleBookingDetails
                                            .value
                                            .subcategory
                                            ?.hourRate
                                            .toString() ??
                                            '0',
                                      });
                                },
                                child: Text(
                                  'Stop Work',
                                  style: AppStyles.fontSize20(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                // Rest of the UI remains the same
                Card(
                  color: AppColors.lightPurpleColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            _singleBookingController.singleBookingDetails.value.category?.category ?? 'No Category',
                            style: AppStyles.fontSize18(
                                color: AppColors.blackColor, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreenColor,
                                  borderRadius: BorderRadius.circular(8.sp),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${_singleBookingController.singleBookingDetails.value.subcategory?.hourRate ?? '0'} /hr',
                                    style: AppStyles.fontSize16(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.darkGrayColor,
                                    ),
                                  ),
                                ),
                              ),
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
                            _singleBookingController.singleBookingDetails.value.description ?? 'No Description',
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
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Total Task",
                        style: AppStyles.fontSize18(
                            fontWeight: FontWeight.w500, color: AppColors.primaryColor),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _singleBookingController.singleBookingDetails.value.serviceTasks?.length.toString() ?? '0',
                        style: AppStyles.fontSize18(
                            fontWeight: FontWeight.w500, color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  itemCount: _singleBookingController.singleBookingDetails.value.serviceTasks?.length ?? 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final task = _singleBookingController.singleBookingDetails.value.serviceTasks?[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                      child: CustomListButton(
                        label: task?.task ?? 'No Task',
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
                      target: LatLng(
                          _singleBookingController.singleBookingDetails.value.user?.location?.coordinates?[1] ?? 0.0,
                          _singleBookingController.singleBookingDetails.value.user?.location?.coordinates?[0] ?? 0.0),
                      zoom: 12,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('1'),
                        position: LatLng(
                            _singleBookingController.singleBookingDetails.value.user?.location?.coordinates?[1] ?? 0.0,
                            _singleBookingController.singleBookingDetails.value.user?.location?.coordinates?[0] ?? 0.0),
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
                      "${_singleBookingController.singleBookingDetails.value.user?.firstName ?? 'User'}'s Info",
                      style: AppStyles.fontSize20(
                          fontWeight: FontWeight.w700, color: AppColors.darkGrayColor),
                    ),
                  ],
                ),
                SizedBox(height: 4.sp),
                Row(
                  children: [
                    const Icon(Icons.home_outlined),
                    const SizedBox(width: 8),
                    Text(
                      "${_singleBookingController.singleBookingDetails.value.user?.firstName ?? 'User'}'s Home",
                      style: AppStyles.fontSize20(
                          fontWeight: FontWeight.w700, color: AppColors.darkGrayColor),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    AppStrings.exampleLocation,
                    style: AppStyles.fontSize14(
                        fontWeight: FontWeight.w500, color: AppColors.hintColor),
                  ),
                ),
                SizedBox(height: 8.sp),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    AppStrings.navigateToAddress,
                    style: AppStyles.fontSize16(
                        fontWeight: FontWeight.w500, color: AppColors.primaryColor),
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
                      "${_singleBookingController.singleBookingDetails.value.user?.firstName ?? 'User'}'s Home Phone",
                      style: AppStyles.fontSize20(
                          fontWeight: FontWeight.w700, color: AppColors.darkGrayColor),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    _singleBookingController.singleBookingDetails.value.user?.email ?? 'No Email',
                    style: AppStyles.fontSize14(
                        fontWeight: FontWeight.w500, color: AppColors.hintColor),
                  ),
                ),
                SizedBox(height: 8.sp),
                Container(
                  height: 2,
                  color: AppColors.hintColor,
                ),
                SizedBox(height: 24.sp),
                // Start Work Button
                _singleBookingController.singleBookingDetails.value.status == 'accepted'
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 16.sp),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        onPressed: () {
                          _workController.startWork();
                          setState(() {}); // Refresh the page
                        },
                        child: const Text(
                          'Start Work',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
                    : SizedBox(),
                SizedBox(height: 24.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}