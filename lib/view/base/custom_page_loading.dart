import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:home_health_app/utils/app_colors.dart';


class CustomPageLoading extends StatelessWidget {
  const CustomPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitCircle(
        color:AppColors.primaryColor,
        size: 60.0,
    ),);
  }
}

