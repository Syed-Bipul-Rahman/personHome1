import 'package:flutter/material.dart';
import 'package:home_health_app/utils/app_colors.dart';

class CustomFillButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomFillButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.purpleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Custom padding
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.add_circle_outline,
            color: Colors.white, // Icon color
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16, // Font size
            ),
          ),
        ],
      ),
    );
  }
}
