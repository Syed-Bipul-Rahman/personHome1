import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_health_app/view/base/custom_page_loading.dart';

import '../../../../../controller/booking/my_booking_controller.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../BottomMenuBar/user_bottom_menu.dart';
import 'care_plane_card.dart';

class CarePlanScreen extends StatefulWidget {
  const CarePlanScreen({super.key});

  @override
  State<CarePlanScreen> createState() => _CarePlanScreenState();
}

class _CarePlanScreenState extends State<CarePlanScreen> {
  final _myBookingController = Get.put(MyBookingController());
  String selectedFilter = 'All'; // Tra

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _myBookingController.fetchMyBooking();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const UserBottomNavigationBar(1),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20.sp),
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
                      AppStrings.carePlan,
                      style: AppStyles.fontSize20(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor),
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      border: Border.all(color: AppColors.greyColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedFilter,
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          elevation: 16,
                          style: AppStyles.fontSize16(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blackColor,
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              selectedFilter = value!;
                              print("Selected value is ===>" + selectedFilter);

                              if (selectedFilter == 'All') {
                                _myBookingController.fetchMyBooking();
                              }
                              else {
                                _myBookingController.fetchMyBooking(status: selectedFilter);
                              }

                            });
                          },
                          items: [
                            DropdownMenuItem(
                              value: 'All',
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.filterList,
                                    height: 20.sp,
                                    width: 20.sp,
                                  ),
                                  const SizedBox(width: 10),
                                  Text('All'),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'pending',
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.filterList,
                                    height: 20.sp,
                                    width: 20.sp,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text('Pending'),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'completed',
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.filterList,
                                    height: 20.sp,
                                    width: 20.sp,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text('Completed'),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'in-Progress',
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.filterList,
                                    height: 20.sp,
                                    width: 20.sp,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text('In Progress'),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'accepted',
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.filterList,
                                    height: 20.sp,
                                    width: 20.sp,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text('Accepted'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() {
                if (_myBookingController.isLoading.value) {
                  return const Center(
                    child: CustomPageLoading(),
                  );
                }

                // Check for empty list
                if (_myBookingController.myBookingList.isEmpty) {
                  return Center(
                    child: Text(
                      'No care plans available.',
                      style: AppStyles.fontSize16(
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyColor),
                    ),
                  );
                }

                // Display list of care plans
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return CarePlaneCardWidget(
                      booking: _myBookingController.myBookingList[index],
                    );
                  },
                  itemCount: _myBookingController.myBookingList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
