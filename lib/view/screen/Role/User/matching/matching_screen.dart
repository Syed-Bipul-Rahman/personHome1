import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health_app/controller/matching/matching_controller.dart';
import 'package:home_health_app/view/base/custom_page_loading.dart';
import 'package:logger/logger.dart';

import '../../../../../service/api_constants.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_images.dart';

class CaregiverListScreen extends StatefulWidget {
  CaregiverListScreen({super.key});

  @override
  State<CaregiverListScreen> createState() => _CaregiverListScreenState();
}

class _CaregiverListScreenState extends State<CaregiverListScreen> {
  final MatchingController _matchingController = Get.put(MatchingController());
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();

    _matchingController.setMinRange(int.parse(Get.parameters['minRange']!));
    _matchingController.setMaxRange(int.parse(Get.parameters['maxRange']!));
    logger.i("Min Range: ${_matchingController.minRange.value}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _matchingController.getMatchingData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: const Text("Caregivers"),
      ),
      body: Obx(() {
        if (_matchingController.isLoading.value) {
          // Display loading indicator
          return const Center(
            child: CustomPageLoading(),
          );
        } else if (_matchingController.caregiverMatchingList.isEmpty) {
          // Display empty state
          return const Center(
            child: Text(
              "No caregivers found.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          );
        } else {
          // Display caregiver list
          return ListView.builder(
            itemCount: _matchingController.caregiverMatchingList.length,
            itemBuilder: (context, index) {
              final caregiver = _matchingController.caregiverMatchingList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child:Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: caregiver.image?.url != null
                          ? NetworkImage(ApiConstants.baseUrl + caregiver.image!.url) as ImageProvider
                          : AssetImage(AppImages.appLogo) as ImageProvider,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            caregiver.firstName ?? "Unknown",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Caregiver",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      "2 KM",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
