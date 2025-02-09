import 'package:flutter/material.dart';
import 'package:home_health_app/utils/app_colors.dart';

class CustomListButton extends StatelessWidget {
  final String label;
  final Function(String)? onEdit;
  final VoidCallback? onDelete;

  const CustomListButton({
    required this.label,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.lightPurpleColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.greyColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}