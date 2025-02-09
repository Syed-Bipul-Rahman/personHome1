import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_health_app/controller/job/job_list_controller.dart';
import 'package:home_health_app/service/api_constants.dart';
import 'package:home_health_app/view/base/cached_network_image.dart';
import 'package:home_health_app/view/base/custom_page_loading.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/style.dart';
import '../../../base/care_giver_app_bar.dart';
import '../../../base/custom_drawer.dart';
import '../../BottomMenuBar/caregiver_bottom_menubar.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({super.key});

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  final JobListController _jobListController = Get.put(JobListController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _jobListController.getJobListNotification();
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CareGiverAppBar(),
      bottomNavigationBar: CaregiverBottomNavigationBar(1),
      drawer: CustomNavigationDrawer(),
      body: Obx(() {
        if (_jobListController.isLoading.value) {
          // Show loading spinner
          return Center(child: CustomPageLoading());
        } else if (_jobListController.notificationList.isEmpty) {
          // Show empty state message
          return Center(
            child: Text(
              "No jobs available at the moment.",
              style: AppStyles.fontSize16(
                  fontWeight: FontWeight.w500, color: AppColors.darkGrayColor),
            ),
          );
        } else {
          // Display the job list
          return  ListView.builder(
            itemCount: _jobListController.notificationList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.shiftDetailsScreen, parameters: {
                          'notificationId': _jobListController.notificationList[index].id,
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
                                child: CustomNetworkImage(
                                  imageUrl: ApiConstants.baseUrl +
                                      _jobListController.notificationList[index]
                                          .bookingId!.categoryId.image.url,
                                  height: 120.h,
                                  width: 120.w,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _jobListController.notificationList[index]
                                          .bookingId!.categoryId.category,
                                      style: AppStyles.fontSize18(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.darkGrayColor),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
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
                                          _jobListController.notificationList[index].status,
                                          style: AppStyles.fontSize14(
                                              color: AppColors.darkGrayColor,
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        const Icon(Icons.map_outlined),
                                        const SizedBox(width: 4.0),
                                        Expanded(
                                          child: Text(
                                            _jobListController.notificationList[index]
                                                .bookingId!.user.location.locationName
                                                .toString(),
                                            style: AppStyles.fontSize14(
                                                color: AppColors.hintColor,
                                                fontWeight: FontWeight.w500),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
        }
      }),
    );
  }
}
