import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_health_app/controller/category/category_controller.dart';
import 'package:home_health_app/helpers/route.dart';
import 'package:home_health_app/service/api_constants.dart';
import 'package:home_health_app/utils/app_colors.dart';
import 'package:home_health_app/utils/app_strings.dart';
import 'package:home_health_app/utils/style.dart';
import 'package:home_health_app/view/base/cached_network_image.dart';
import 'package:home_health_app/view/base/custom_search_bar.dart';
import 'package:home_health_app/view/screen/BottomMenuBar/user_bottom_menu.dart';
import '../../../../../controller/job/job_posts_controller.dart';
import '../../../../../service/firebase_service.dart';
import '../../../../base/custom_app_bar.dart';

class UserHomePageScreen extends StatefulWidget {
  const UserHomePageScreen({super.key});

  @override
  State<UserHomePageScreen> createState() => _UserHomePageScreenState();
}

class _UserHomePageScreenState extends State<UserHomePageScreen> {
  final JobPostsController jobPostsController = Get.put(JobPostsController());
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  void initState() {
    NotificationHelper.firebaseListenNotification(context: context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: const UserBottomNavigationBar(0),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings.howCanWeAssistYouAtHomeToday,
                style: AppStyles.fontSize24(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomSearchBar(),
            ),
            const SizedBox(height: 8.0),
            _buildSectionTitle("Services", AppRoutes.allCategoryScreen),
            Obx(() {
              if (categoryController.isLoading.value) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoActivityIndicator(
                        radius: 32.0,
                        color: CupertinoColors.activeBlue,
                      ),
                    ],
                  ),
                );
              }
              return categoryController.categoryNames.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No Service available at this moment'),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 116.w,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: categoryController.categoryNames.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.subCategoryScreen,
                                arguments: {
                                  AppStrings.category:
                                      categoryController.categoryNames[index],
                                  AppStrings.catId:
                                      categoryController.categoryIds[index],
                                },
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100.h,
                                  width: 100.w,
                                  decoration: const BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.w),
                                    child: CustomNetworkImage(
                                      imageUrl: ApiConstants.baseUrl +
                                          categoryController.CAT_IMAGES[index],
                                      height: 50.h,
                                      width: 50.w,
                                    ),
                                  ),
                                ),
                                Text(
                                  categoryController.categoryNames[index],
                                  style: AppStyles.fontSize18(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
            }),
            // const SizedBox(height: 8.0),
            // _buildSectionTitle(AppStrings.recentJobs, null),
            // Obx(() {
            //   if (jobPostsController.isLoading.value) {
            //     return const Center(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           // Cupertino activity indicator with custom radius and color.
            //           CupertinoActivityIndicator(
            //             radius: 32.0,
            //             color: CupertinoColors.activeBlue,
            //           ),
            //         ],
            //       ),
            //     );
            //   }
            //
            //   //job posts list
            //   return jobPostsController.jobTitles.isEmpty
            //       ? const Center(
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text('No recent job posts available for now'),
            //             ],
            //           ),
            //         )
            //       : SizedBox(
            //           height: 220.h,
            //           child: ListView.builder(
            //             scrollDirection: Axis.horizontal,
            //             itemCount: jobPostsController.jobTitles.length,
            //             itemBuilder: (context, index) {
            //               return InkWell(
            //                 onTap: () {
            //                   Get.toNamed(AppRoutes.jobDetailsScreen,
            //                       arguments: {
            //                         'jobTitle':
            //                             jobPostsController.jobTitles[index],
            //                         'jobId': jobPostsController.jobIds[index],
            //                       });
            //                 },
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: JobCard(
            //                     jobTitle: jobPostsController.jobTitles[index],
            //                     jobDescription:
            //                         jobPostsController.jobTitles[index],
            //                     companyName: 'Big Heart',
            //                   ),
            //                 ),
            //               );
            //             },
            //           ),
            //         );
            // }),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String? route) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
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
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: AppStyles.fontSize20(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (route != null)
          InkWell(
            onTap: () {
              Get.toNamed(route);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings.seeAll,
                style: AppStyles.fontSize16(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
