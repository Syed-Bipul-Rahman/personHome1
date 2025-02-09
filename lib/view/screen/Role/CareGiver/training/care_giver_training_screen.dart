import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_health_app/controller/training_controller.dart';
import 'package:home_health_app/service/api_constants.dart';
import 'package:home_health_app/utils/app_constants.dart';

import '../../../../../helpers/route.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/care_giver_app_bar.dart';
import '../../../../base/custom_drawer.dart';
import '../../../../base/custom_page_loading.dart';

class CareGiverTrainingScreen extends StatefulWidget {
  const CareGiverTrainingScreen({super.key});

  @override
  State<CareGiverTrainingScreen> createState() =>
      _CareGiverTrainingScreenState();
}

class _CareGiverTrainingScreenState extends State<CareGiverTrainingScreen> {
  final TrainingController trainingController = Get.put(TrainingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CareGiverAppBar(),
      drawer: CustomNavigationDrawer(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (trainingController.isLoading.value) {
                  return const Center(child: CustomPageLoading());
                }

                if (trainingController.trainingList.isEmpty) {
                  return Center(
                    child: Text(
                      'No data available',
                      style: AppStyles.fontSize18(
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyColor,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: trainingController.trainingList.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    final mediaUrl = trainingController
                        .trainingList[index].media!.file!.url!;
                    final isVideo = mediaUrl.toLowerCase().endsWith('.mp4');
                    final isPdf = mediaUrl.toLowerCase().endsWith('.pdf');
                    return InkWell(
                      onTap: () {
                        if (isPdf) {
                          Get.toNamed(AppRoutes.pdfViewScreen, parameters: {
                            'mediaUrl': trainingController
                                .trainingList[index].media!.file!.url!,
                          });
                          return;
                        } else if (isVideo) {
                          Get.toNamed(AppRoutes.trainingDetailsScreen,
                              parameters: {
                                'mediaUrl': trainingController
                                    .trainingList[index].media!.file!.url!,
                              });
                          return;
                        }
                      },
                      child: Card(
                        color: AppColors.lightPurpleColor,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: isVideo
                                    ? Image.asset(
                                        AppImages.playVideoPlaceholder,
                                        height: 120.h,
                                        width: 120.w,
                                        fit: BoxFit.cover,
                                      )
                                    : isPdf
                                        ? Image.asset(
                                            AppImages.pdfViewPlaceholder,
                                            height: 120.h,
                                            width: 120.w,
                                            fit: BoxFit.fitHeight,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl:
                                                ApiConstants.baseUrl + mediaUrl,
                                            height: 120.h,
                                            width: 120.w,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              AppImages.placeholder,
                                              height: 120.h,
                                              width: 120.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, right: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    trainingController
                                        .trainingList[index].trainingName??'No name',
                                    style: AppStyles.fontSize18(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.darkGrayColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time_filled),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        AppStrings.fiveHr,
                                        style: AppStyles.fontSize18(
                                          color: AppColors.greyColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
