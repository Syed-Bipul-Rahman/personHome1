import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_health_app/service/api_constants.dart';
import 'package:home_health_app/utils/app_colors.dart';
import 'package:home_health_app/utils/app_images.dart';
import 'package:home_health_app/utils/app_strings.dart';
import 'package:home_health_app/view/base/custom_dropdown.dart';

import '../../../../../helpers/route.dart';
import '../../../../../models/booking/my_booking_model.dart';

class CarePlaneCardWidget extends StatelessWidget {
  final Booking booking;



  const CarePlaneCardWidget({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.carePlanDetailsScreen, parameters: {'booking': booking.id!});
      },
      child: Card(
        color: AppColors.cardbgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        width: 50.0,
                        height: 50.0,
                        imageUrl: ApiConstants.baseUrl + (booking.categoryId?.image!.url ?? ''),
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.categoryId!.category!.isNotEmpty ? booking.categoryId!.category! : 'No name',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const Divider(color: Colors.grey),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Status",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.dividerColor,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: booking.status == "pending"
                            ? Colors.orange
                            : booking.status == "completed"
                            ? Colors.green
                            : booking.status == "canceled"
                            ? Colors.red
                            : booking.status == "accepted"
                            ? Colors.blue
                            : booking.status == "in-Progress"
                            ? AppColors.inRequestColor
                            : Colors.grey,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          booking.status ?? 'Unknown',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: const Icon(Icons.calendar_today, color: Colors.grey),
                  ),
                  const SizedBox(width: 20.0),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.eightToNineAM + AppStrings.nineDec,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Schedule",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.silverColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              if (booking.acceptBy != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [

                          Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: booking.acceptBy?.image?.url != null
                                ? CachedNetworkImage(
                              width: 50.0,
                              height: 50.0,
                              imageUrl: ApiConstants.baseUrl + booking.acceptBy!.image!.url!,
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => ClipOval(
                                child: Image.asset(
                                  AppImages.placeholder,
                                  fit: BoxFit.cover,
                                  width: 50.0,
                                  height: 50.0,
                                ),
                              ),
                            )
                                : ClipOval(
                              child: Image.asset(
                                AppImages.placeholder,
                                fit: BoxFit.cover,
                                width: 50.0,
                                height: 50.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                booking.acceptBy?.fullName?.isNotEmpty == true
                                    ? booking.acceptBy!.fullName!
                                    : 'No name available',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                               'Caregiver',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.silverColor,
                                ),
                              ),
                            ],
                          ),


                        ],
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(8.0),
                      //     color: AppColors.primaryColor,
                      //   ),
                      //   child: const Padding(
                      //     padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      //     child: Icon(Icons.message, color: Colors.white),
                      //   ),
                      // ),
                    ],
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
