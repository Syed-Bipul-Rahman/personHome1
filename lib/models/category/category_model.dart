import 'dart:convert';

class CategoryResponse {
  final int code;
  final String message;
  final CategoryData data;

  CategoryResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      code: json['code'],
      message: json['message'],
      data: CategoryData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class CategoryData {
  final Attributes attributes;

  CategoryData({
    required this.attributes,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      attributes: Attributes.fromJson(json['attributes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attributes': attributes.toJson(),
    };
  }
}

class Attributes {
  final List<CategoryResult> results;
  final int page;
  final int limit;
  final int totalPages;
  final int totalResults;

  Attributes({
    required this.results,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalResults,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      results: List<CategoryResult>.from(
          json['results'].map((x) => CategoryResult.fromJson(x))),
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
      totalResults: json['totalResults'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((x) => x.toJson()).toList(),
      'page': page,
      'limit': limit,
      'totalPages': totalPages,
      'totalResults': totalResults,
    };
  }
}

class CategoryResult {
  final String category;
  final String description;
  final List<SubCategory> subCategories;
  final String id;
  final String image;

  CategoryResult({
    required this.category,
    required this.description,
    required this.subCategories,
    required this.id,
    required this.image,
  });

  factory CategoryResult.fromJson(Map<String, dynamic> json) {
    return CategoryResult(
      image: json['image']['url'],
      category: json['category'],
      description: json['description'],
      subCategories: List<SubCategory>.from(
          json['subCategories'].map((x) => SubCategory.fromJson(x))),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'description': description,
      'subCategories': subCategories.map((x) => x.toJson()).toList(),
      'id': id,
    };
  }
}

class SubCategory {
  final String id;
  final String name;
  final String description;
  final String hourRate;
  final Image image;
  final String categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  SubCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.hourRate,
    required this.image,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      hourRate: json['hourRate'],
      image: Image.fromJson(json['image']),
      categoryId: json['categoryId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'hourRate': hourRate,
      'image': image.toJson(),
      'categoryId': categoryId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}

class Image {
  final String url;
  final String path;

  Image({
    required this.url,
    required this.path,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      url: json['url'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'path': path,
    };
  }
}
