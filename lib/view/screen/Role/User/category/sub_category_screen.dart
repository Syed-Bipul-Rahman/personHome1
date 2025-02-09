import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_health_app/controller/category/category_controller.dart';
import 'package:home_health_app/service/api_constants.dart';
import 'package:home_health_app/utils/app_colors.dart';
import 'package:home_health_app/view/base/cached_network_image.dart';
import 'package:home_health_app/view/base/custom_page_loading.dart';

import '../../../../../helpers/route.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_text.dart';

class SubCategoryScreen extends StatefulWidget {
  SubCategoryScreen({super.key});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final CategoryController controller = Get.find<CategoryController>();
  var categoryName = '';

  @override
  void initState() {
    final arguments = Get.arguments;
    categoryName = arguments[AppStrings.category];
    final categoryId = arguments[AppStrings.catId];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchSubCategory(categoryId);
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          text: categoryName,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.w),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CustomPageLoading(),
            );
          }

          if (controller.subCategoryNames.isEmpty) {
            return Center(
              child: Text(
                "No Subcategories Available",
                style: AppStyles.fontSize16(
                  fontWeight: FontWeight.w600,
                  color: AppColors.assColorColor,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: controller.subCategoryNames.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.addTaskScreen, parameters: {
                    "subcategoryName": controller.subCategoryNames[index],
                    "catId": controller.categoryIds[index],
                    "subCatId": controller.subCategoryIds[index],
                    "subCatPrice": controller.subCatHourRate[index],
                    "subCatImage": controller.SUB_CAT_IMAGES[index],
                  });
                },
                child: Card(
                  color: AppColors.lightPurpleColor,
                  child: Container(
                    height: 200.h,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          // child: Image.asset(
                          //   AppImages.subCategoryImageOne,
                          //   height: 150.h,
                          //   width: 150.w,
                          //   fit: BoxFit.cover,
                          // ),

                          child: CustomNetworkImage(
                            boxShape: BoxShape.rectangle,
                            imageUrl: ApiConstants.baseUrl +
                                controller.SUB_CAT_IMAGES[index],
                            height: 150.h,
                            width: 150.h,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Row(
                              //     children: [
                              //       Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceEvenly,
                              //         children: [
                              //           Container(
                              //             height: 30,
                              //             width: 30,
                              //             child: SvgPicture.asset(
                              //               AppIcons.starIcon,
                              //               fit: BoxFit.scaleDown,
                              //             ),
                              //           ),
                              //           // Image.asset(AppIcons.starIcon),
                              //
                              //           Text(
                              //             AppStrings.fourPointEight,
                              //             style: AppStyles.fontSize18(
                              //                 fontWeight: FontWeight.w700,
                              //                 color: AppColors.blackColor),
                              //           ),
                              //           Text(
                              //             " (${AppStrings.eightySeven})",
                              //             style: AppStyles.fontSize18(
                              //                 fontWeight: FontWeight.w700,
                              //                 color: AppColors.assColorColor),
                              //           ),
                              //         ],
                              //       ),
                              //       SizedBox(width: 41.w),
                              //       Container(
                              //         height: 30,
                              //         width: 30,
                              //         child: SvgPicture.asset(
                              //           AppIcons.three_dot,
                              //           fit: BoxFit.scaleDown,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Center(
                                heightFactor: 1.5,
                                child: Column(
                                  children: [
                                    Text(
                                      controller.subCategoryNames[index],
                                      style: AppStyles.fontSize18(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.blackColor),
                                    ),
                                    Text(
                                      AppStrings.startsFrom,
                                      style: AppStyles.fontSize18(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.assColorColor),
                                    ),
                                    Card(
                                      color: AppColors.lightGreenColor,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0,
                                            bottom: 8.0,
                                            left: 16.0,
                                            right: 16.0),
                                        child: Text(
                                          "\$${controller.subCatHourRate[index]}/hr",
                                          style: AppStyles.fontSize18(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.blackColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
