import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_health_app/controller/category/category_controller.dart';
import '../../../../../helpers/route.dart';
import '../../../../../service/api_constants.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/cached_network_image.dart';
import '../../../../base/custom_text.dart';

class AllCategory extends StatefulWidget {
  AllCategory({super.key});

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          text:"All Services",
          fontSize: 18.sp,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppStrings.allCategories,
                    style: AppStyles.fontSize20(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Obx(
                () => GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 1.0,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: CustomNetworkImage(
                                  imageUrl: ApiConstants.baseUrl +
                                      categoryController
                                          .CAT_IMAGES[index],
                                  height: 60.h,
                                  width: 60.w),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              categoryController.categoryNames[index],
                              style: AppStyles.fontSize16(
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
