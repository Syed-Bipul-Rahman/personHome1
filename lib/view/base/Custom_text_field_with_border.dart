import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class CustomTextFieldWithBorder extends StatefulWidget {
  final TextEditingController controller;
  final String hint;

  const CustomTextFieldWithBorder({
    Key? key,
    required this.controller,
    required this.hint,

  }) : super(key: key);

  @override
  _CustomTextFieldWithBorderState createState() =>
      _CustomTextFieldWithBorderState();
}

class _CustomTextFieldWithBorderState extends State<CustomTextFieldWithBorder> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            _isFocused = hasFocus;
          });
        },
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: Colors.grey), // Customize if needed
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(width: 1.0, color: AppColors.primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(width: 1.0, color:  AppColors.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(width: 1.0, color:  AppColors.primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
