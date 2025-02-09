
import 'category_model.dart';

class SubCategoryResponse {
  final String category;
  final String description;
  final List<SubCategory> subCategories;
  final String id;

  SubCategoryResponse({
    required this.category,
    required this.description,
    required this.subCategories,
    required this.id,
  });

  factory SubCategoryResponse.fromJson(Map<String, dynamic> json) {
    return SubCategoryResponse(
      category: json['category'] as String,
      description: json['description'] as String,
      subCategories: (json['subCategories'] as List<dynamic>)
          .map((subCategory) => SubCategory.fromJson(subCategory))
          .toList(),
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'description': description,
      'subCategories': subCategories.map((subCategory) => subCategory.toJson()).toList(),
      'id': id,
    };
  }
}
