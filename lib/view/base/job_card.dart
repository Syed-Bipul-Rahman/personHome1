import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_health_app/utils/app_colors.dart';
import 'package:home_health_app/utils/app_images.dart';
import 'package:home_health_app/utils/app_strings.dart';

class JobCard extends StatelessWidget {
  final String companyName;
  final String jobTitle;
  final String jobDescription;

  const JobCard({super.key, required this.companyName, required this.jobTitle, required this.jobDescription,});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.lightPurpleColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(AppImages.appLogo, width: 40, height: 40),
                Icon(
                  Icons.favorite_border,
                  size: 24,
                  color: AppColors.whiteColor,
                ),
              ],
            ),
            const SizedBox(height: 16),

            //======================= Company name  =======================
            Text(
              companyName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
              maxLines: 1, // Limit to one line
              overflow: TextOverflow.ellipsis, // Show ellipsis if text overflows
            ),
            const SizedBox(height: 8), // Space

            //======================= Job Title  =======================
            Text(
              jobTitle,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGrayColor,
              ),
              maxLines: 2, // Limit to two lines
              overflow: TextOverflow.ellipsis, // Show ellipsis if text overflows
            ),
            const SizedBox(height: 8), // Space

            // ======================= Job Description  =======================
            Flexible(
              child: Text(
                jobDescription,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
                maxLines: 3, // Limit to three lines
                overflow: TextOverflow.ellipsis, // Show ellipsis if text overflows
              ),
            ),
          ],
        ),
      ),
    );
  }
}