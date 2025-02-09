import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String hint;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final TextEditingController controller;

  CustomDropdown({
    required this.items,
    required this.hint,
    required this.controller,
    required this.onChanged, this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(

        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.w),
          borderRadius: BorderRadius.circular(8.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.w),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.w),
          borderRadius: BorderRadius.circular(8.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          iconDisabledColor: AppColors.primaryColor, // AppColors.primaryColor
          icon: Icon(Icons.arrow_drop_down_outlined),
          iconEnabledColor: AppColors.primaryColor, // AppColors.primaryColor
          isExpanded: true,
          value: controller.text.isEmpty ? null : controller.text,
          hint: Text(controller.text.isEmpty ? hint : controller.text),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            controller.text = newValue ?? '';
            onChanged(newValue);
          },
        ),
      ),
    );
  }
}
