import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_health_app/view/base/custom_page_loading.dart';
import '../../../../controller/booking/my_booking_list_controller.dart';
import '../../../../controller/care_giver_home_controller.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/care_giver_app_bar.dart';
import '../../../base/custom_drawer.dart';
import '../../../base/custom_tab_widget.dart';
import '../../BottomMenuBar/caregiver_bottom_menubar.dart';

class CareGiverHomeScreen extends StatefulWidget {
  const CareGiverHomeScreen({super.key});

  @override
  State<CareGiverHomeScreen> createState() => _CareGiverHomeScreenState();
}

class _CareGiverHomeScreenState extends State<CareGiverHomeScreen> {
  final CareGiverHomeController controller = Get.put(CareGiverHomeController());
  final MyBookingListController _myBookingListController =
  Get.put(MyBookingListController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _myBookingListController.fetchMyBookedList();
      _myBookingListController.fetchCompletedBookedList();
    });
  }

  void _handleTabChange(int index) {
    if (index == 0) {
      _myBookingListController.fetchMyBookedList();
    } else {
      _myBookingListController.fetchCompletedBookedList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CareGiverAppBar(),
        bottomNavigationBar: CaregiverBottomNavigationBar(0),
        drawer: CustomNavigationDrawer(),
        body: CustomTabWidget(
            tabs: const [
              "Accepted",
              "Completed",
            ],
            onTabChanged: _handleTabChange,
        tabContents: [
          Obx(() {
            if (_myBookingListController.isLoading.value) {
              return const Center(child: CustomPageLoading());
            }
            if (_myBookingListController.acceptedBookingList.isEmpty) {
              return const Center(
                  child: Text("No Accepted Bookings Available"));
            }
            return ListView.builder(
              itemCount: _myBookingListController.acceptedBookingList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.bookingDetailsScreen,
                              parameters: {
                                'bookingId': _myBookingListController
                                    .acceptedBookingList[index].id!,
                              });
                        },
                        child: Card(
                          color: AppColors.lightPurpleColor,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    AppImages.subCategoryImageOne,
                                    height: 120.h,
                                    width: 120.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _myBookingListController
                                          .acceptedBookingList[index]
                                          .categoryId!
                                          .category,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Container(
                                          height: 16,
                                          width: 16,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.orangeAccentColor,
                                          ),
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          _myBookingListController
                                              .acceptedBookingList[index]
                                              .status!,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
          Obx(() {
            if (_myBookingListController.isCompleteLoading.value) {
              return const Center(child: CustomPageLoading());
            }
            if (_myBookingListController.completedBookingList.isEmpty) {
              return const Center(
                  child: Text("No Completed Bookings Available"));
            }
            return ListView.builder(
              itemCount: _myBookingListController.completedBookingList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.bookingDetailsScreen,
                              parameters: {
                                'bookingId': _myBookingListController
                                    .completedBookingList[index].id,
                              });
                        },
                        child: Card(
                          color: AppColors.lightPurpleColor,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    AppImages.subCategoryImageOne,
                                    height: 120.h,
                                    width: 120.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _myBookingListController
                                          .completedBookingList[index]
                                          .categoryId
                                          .category,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Container(
                                          height: 16,
                                          width: 16,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.orangeAccentColor,
                                          ),
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          _myBookingListController
                                              .completedBookingList[index]
                                              .status,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
