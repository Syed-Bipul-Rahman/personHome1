import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_health_app/helpers/time_formate.dart';

import '../../../../../controller/job/single_job_post_controller.dart';
import '../../../../../helpers/route.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_button.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  SingleJobPostsController jobPostsController =
      Get.put(SingleJobPostsController());

  @override
  void initState() {
    super.initState();

    // Fetch job details when the widget initializes
    final arguments = Get.arguments;
    final jobId = arguments['jobId'];
    jobPostsController.fetchSingleJobPost(jobId);
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final jobTitle = arguments['jobTitle'];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Obx(() {
        final jobPost = jobPostsController.jobPost.value;

        if (jobPostsController.isLoading.value==true) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Cupertino activity indicator with custom radius and color.
                CupertinoActivityIndicator(
                  radius: 32.0,
                  color: CupertinoColors.activeBlue,
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
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
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        child: Text(
                          jobTitle,
                          style: AppStyles.fontSize20(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        AppStrings.dhakaBangladesh,
                        style: AppStyles.fontSize18(
                            color: AppColors.greyColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ),
                    Text(
                      TimeFormatHelper.dateMountFormat(jobPost.postedAt),
                      style: AppStyles.fontSize18(
                          color: AppColors.greyColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                            jobPost.jobType,
                            style: AppStyles.fontSize16(
                              color: AppColors.veryLightreenColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(8.sp),
                    //       color: AppColors.lightGreenColor,
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Text(
                    //         jobPost.category,
                    //         style: AppStyles.fontSize16(
                    //           color: AppColors.veryLightreenColor,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      text: jobPost.description,
                      style: AppStyles.fontSize18(color: AppColors.blackColor),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Text(
                        AppStrings.requirements,
                        style: AppStyles.fontSize20(
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkGrayColor),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: jobPost.jobRequirements.length,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 4,
                            width: 4,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.darkGrayColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              text: jobPost.jobRequirements[index].requirement,
                              style: AppStyles.fontSize18(
                                  color: AppColors.blackColor),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Row(
                    children: [
                      Text(
                        AppStrings.qualifications,
                        style: AppStyles.fontSize20(
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkGrayColor),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: jobPost.qualifications.length,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 4,
                            width: 4,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.darkGrayColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              text: jobPost.qualifications[index].qualification,
                              style: AppStyles.fontSize18(
                                  color: AppColors.blackColor),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    textColor: AppColors.textColor,
                    onTap: () {
                      Get.toNamed(AppRoutes.applyJobStepOneScreen,
                          arguments: {'jobId': jobPost.id});
                    },
                    text: AppStrings.apply.tr,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
