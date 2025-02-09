class SingleBookingModel {
  final dynamic categoryId; // Can be null or an object
  final String? userId;
  final Booking? bookingId;
  final String? transactionId;
  final String? role;
  final String? title;
  final String? content;
  final String? devStatus;
  final String? image;
  final String? status;
  final bool? isActive;
  final String? type;
  final String? priority;
  final List<ServiceTask>? serviceTasks;
  final String? createdAt;
  final String? updatedAt;
  final String? id;

  SingleBookingModel({
    this.categoryId,
    this.userId,
    this.bookingId,
    this.transactionId,
    this.role,
    this.title,
    this.content,
    this.devStatus,
    this.image,
    this.status,
    this.isActive,
    this.type,
    this.priority,
    this.serviceTasks,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory SingleBookingModel.fromJson(Map<String, dynamic> json) {
    return SingleBookingModel(
      categoryId: json['categoryId'],
      userId: json['userId'],
      bookingId: json['bookingId'] != null ? Booking.fromJson(json['bookingId']) : null,
      transactionId: json['transactionId'],
      role: json['role'],
      title: json['title'],
      content: json['content'],
      devStatus: json['devStatus'],
      image: json['image'],
      status: json['status'],
      isActive: json['isActive'],
      type: json['type'],
      priority: json['priority'],
      serviceTasks: json['serviceTasks'] != null
          ? (json['serviceTasks'] as List).map((task) => ServiceTask.fromJson(task)).toList()
          : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      id: json['id'],
    );
  }
}

class Booking {
  final User? user;
  final String? description;
  final Category? categoryId;
  final SubCategory? subcategoryId;
  final List<ServiceTask>? serviceTasks;
  final String? status;
  final num? workTime;
  final num? totalAmount;
  final num? hourRate;
  final String? paymentStatus;
  final String? createdAt;
  final String? updatedAt;
  final String? id;

  Booking({
    this.user,
    this.description,
    this.categoryId,
    this.subcategoryId,
    this.serviceTasks,
    this.status,
    this.workTime,
    this.totalAmount,
    this.hourRate,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      description: json['description'],
      categoryId: json['categoryId'] != null ? Category.fromJson(json['categoryId']) : null,
      subcategoryId: json['subcategory_Id'] != null ? SubCategory.fromJson(json['subcategory_Id']) : null,
      serviceTasks: json['serviceTasks'] != null
          ? (json['serviceTasks'] as List).map((task) => ServiceTask.fromJson(task)).toList()
          : null,
      status: json['status'],
      workTime: json['workTime'],
      totalAmount: json['totalAmount'],
      hourRate: json['hourRate'],
      paymentStatus: json['paymentStatus'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      id: json['id'],
    );
  }
}

class User {
  final Location? location;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final Image? image;
  final String? role;
  final num? rand;
  final List<dynamic>? interest;
  final String? fcmToken;
  final dynamic oneTimeCode; // Can be null or a String
  final bool? isEmailVerified;
  final bool? isResetPassword;
  final bool? isInterest;
  final bool? isProfileCompleted;
  final bool? isDeleted;
  final String? createdAt;
  final String? updatedAt;
  final String? id;

  User({
    this.location,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.image,
    this.role,
    this.rand,
    this.interest,
    this.fcmToken,
    this.oneTimeCode,
    this.isEmailVerified,
    this.isResetPassword,
    this.isInterest,
    this.isProfileCompleted,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      email: json['email'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      role: json['role'],
      rand: json['rand'],
      interest: json['interest'],
      fcmToken: json['fcmToken'],
      oneTimeCode: json['oneTimeCode'],
      isEmailVerified: json['isEmailVerified'],
      isResetPassword: json['isResetPassword'],
      isInterest: json['isInterest'],
      isProfileCompleted: json['isProfileCompleted'],
      isDeleted: json['isDeleted'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      id: json['id'],
    );
  }
}


class Location {
  final String type;
  final List<double> coordinates;
  final String locationName;

  Location({
    required this.type,
    required this.coordinates,
    required this.locationName,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: List<double>.from(json['coordinates']),
      locationName: json['locationName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
      'locationName': locationName,
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

class Category {
  final String category;
  final String description;
  final List<String> subCategories;
  final Image image;
  final String id;

  Category({
    required this.category,
    required this.description,
    required this.subCategories,
    required this.image,
    required this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      category: json['category'],
      description: json['description'],
      subCategories: List<String>.from(json['subCategories']),
      image: Image.fromJson(json['image']),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'description': description,
      'subCategories': subCategories,
      'image': image.toJson(),
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
  final String createdAt;
  final String updatedAt;
  final num? v;

  SubCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.hourRate,
    required this.image,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      hourRate: json['hourRate'],
      image: Image.fromJson(json['image']),
      categoryId: json['categoryId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
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
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class ServiceTask {
  final String task;
  final String id;

  ServiceTask({
    required this.task,
    required this.id,
  });

  factory ServiceTask.fromJson(Map<String, dynamic> json) {
    return ServiceTask(
      task: json['task'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'task': task,
      '_id': id,
    };
  }
}
