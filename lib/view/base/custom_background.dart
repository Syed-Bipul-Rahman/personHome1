import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomBackground extends StatelessWidget {
  final Widget child;

  const CustomBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white,
            Colors.white,
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: child,
    );
  }
}
