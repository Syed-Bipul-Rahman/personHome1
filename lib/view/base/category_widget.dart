import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryWidget extends StatelessWidget {
  final categoryController;

  CategoryWidget({required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0, // Adjusted to provide enough height for the content
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryController.categoryList.length,
        itemBuilder: (context, index) {
          var category = categoryController.categoryList[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 100.0, // Fixed size for each item
                  width: 100.0,  // Fixed size for each item
                  decoration: const BoxDecoration(
                    color: Colors.blue, // Replace with AppColors.secondaryColor if defined
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0), // Adjust padding as needed
                    child: SvgPicture.asset(
                      category.iconPath, // Assuming `category.iconPath` holds the icon path
                      width: 50.0, // Adjust size as per requirement
                      height: 50.0, // Adjust size as per requirement
                    ),
                  ),
                ),
                Text(
                  category.name, // Assuming `category.name` holds the category name
                  style: TextStyle(
                    fontSize: 18.0, // Adjust font size as per requirement
                    fontWeight: FontWeight.w600,
                    color: Colors.black, // Replace with AppColors.primaryColor if defined
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}