import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../controller/location_from_map_controller.dart';
import '../../../../../service/location_service.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_page_loading.dart';
import '../../../../base/custom_tab_widget.dart';

class CareGiverUserAddressInfo extends StatefulWidget {
  const CareGiverUserAddressInfo({super.key});

  @override
  State<CareGiverUserAddressInfo> createState() =>
      _CareGiverUserAddressInfoState();
}

class _CareGiverUserAddressInfoState extends State<CareGiverUserAddressInfo> {
  late GoogleMapController mapController;

  static const LatLng _center = LatLng(23.8041, 90.4152);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final LocationController controller = Get.put(LocationController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          SizedBox(
            height: 350.sp,
            child: Obx(
              () {
                if (controller.currentLocation.value == null) {
                  controller
                      .fetchCurrentLocation(); // Ensure location fetch on load
                  return const Center(child: CustomPageLoading());
                } else {
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: controller.currentLocation.value!,
                      zoom: 14,
                    ),
                    onTap: (LatLng location) {
                      controller.updateLocation(location);
                    },
                    markers: controller.marker.value != null
                        ? {controller.marker.value!}
                        : {},
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 16),
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
                AppStrings.lanasInfo,
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
                AppStrings.lanasInfo,
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
              AppStrings.dummyPhoneNumber,
              style: AppStyles.fontSize14(
                  fontWeight: FontWeight.w500, color: AppColors.hintColor),
            ),
          ),
        ],
      ),
    );
  }
}
