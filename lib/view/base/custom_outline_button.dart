import 'package:flutter/material.dart';
import 'package:home_health_app/utils/app_colors.dart';

class CustomOutlineButton extends StatelessWidget {
  final String label;
  final Function(String)? onEdit;
  final VoidCallback? onDelete;

  const CustomOutlineButton({
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
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.darkGrayColor,
              size: 20,
            ),
            onSelected: (String value) {
              if (value == 'edit') {
                onEdit!(label);
              } else if (value == 'delete') {
                onDelete!();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              // const PopupMenuItem<String>(
              //   value: 'edit',
              //   child: Row(
              //     children: [
              //       Icon(Icons.edit, size: 20),
              //       SizedBox(width: 8),
              //       Text('Edit'),
              //     ],
              //   ),
              // ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 20),
                    SizedBox(width: 8),
                    Text('Delete'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}