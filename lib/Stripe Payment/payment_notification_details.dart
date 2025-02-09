class PaymentNotificationModel {
  String? userId;
  String? sendBy;
  Booking? bookingId;
  dynamic categoryId;
  String? transactionId;
  String? role;
  String? title;
  String? content;
  String? status;
  bool? isActive;
  String? type;
  String? priority;
  List<dynamic>? serviceTasks;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? id;

  PaymentNotificationModel({
    this.userId,
    this.sendBy,
    this.bookingId,
    this.categoryId,
    this.transactionId,
    this.role,
    this.title,
    this.content,
    this.status,
    this.isActive,
    this.type,
    this.priority,
    this.serviceTasks,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory PaymentNotificationModel.fromJson(Map<String, dynamic> json) {
    return PaymentNotificationModel(
      userId: json['userId'],
      sendBy: json['sendBy'],
      bookingId: json['bookingId'] != null ? Booking.fromJson(json['bookingId']) : null,
      categoryId: json['categoryId'],
      transactionId: json['transactionId'],
      role: json['role'],
      title: json['title'],
      content: json['content'],
      status: json['status'],
      isActive: json['isActive'],
      type: json['type'],
      priority: json['priority'],
      serviceTasks: json['serviceTasks'] != null ? List<dynamic>.from(json['serviceTasks']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      id: json['id'],
    );
  }
}

class Booking {
  User? user;
  String? description;
  Category? categoryId;
  SubCategory? subcategory_Id;
  List<ServiceTask>? serviceTasks;
  String? status;
  num? workTime;
  num? totalAmount;
  num? hourRate;
  String? paymentStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? acceptBy;
  String? id;

  Booking({
    this.user,
    this.description,
    this.categoryId,
    this.subcategory_Id,
    this.serviceTasks,
    this.status,
    this.workTime,
    this.totalAmount,
    this.hourRate,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.acceptBy,
    this.id,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      description: json['description'],
      categoryId: json['categoryId'] != null ? Category.fromJson(json['categoryId']) : null,
      subcategory_Id: json['subcategory_Id'] != null ? SubCategory.fromJson(json['subcategory_Id']) : null,
      serviceTasks: json['serviceTasks'] != null
          ? List<ServiceTask>.from(json['serviceTasks'].map((x) => ServiceTask.fromJson(x)))
          : null,
      status: json['status'],
      workTime: json['workTime'],
      totalAmount: json['totalAmount'],
      hourRate: json['hourRate'],
      paymentStatus: json['paymentStatus'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      acceptBy: json['acceptBy'],
      id: json['id'],
    );
  }
}

class User {
  Location? location;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  Image? image;
  String? role;
  num? rand;
  List<dynamic>? interest;
  String? fcmToken;
  dynamic oneTimeCode;
  bool? isEmailVerified;
  bool? isResetPassword;
  bool? isInterest;
  bool? isProfileCompleted;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? id;

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
      interest: json['interest'] != null ? List<dynamic>.from(json['interest']) : null,
      fcmToken: json['fcmToken'],
      oneTimeCode: json['oneTimeCode'],
      isEmailVerified: json['isEmailVerified'],
      isResetPassword: json['isResetPassword'],
      isInterest: json['isInterest'],
      isProfileCompleted: json['isProfileCompleted'],
      isDeleted: json['isDeleted'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      id: json['id'],
    );
  }
}

class Location {
  String? type;
  List<double>? coordinates;
  String? locationName;

  Location({
    this.type,
    this.coordinates,
    this.locationName,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: json['coordinates'] != null
          ? List<double>.from(json['coordinates'].map((x) => x.toDouble()))
          : null,
      locationName: json['locationName'],
    );
  }
}

class Image {
  String? url;
  String? path;

  Image({
    this.url,
    this.path,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      url: json['url'],
      path: json['path'],
    );
  }
}

class Category {
  String? category;
  String? description;
  Image? image;
  List<String>? subCategories;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? id;

  Category({
    this.category,
    this.description,
    this.image,
    this.subCategories,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      category: json['category'],
      description: json['description'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      subCategories: json['subCategories'] != null
          ? List<String>.from(json['subCategories'].map((x) => x))
          : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      id: json['id'],
    );
  }
}

class SubCategory {
  String? id;
  String? name;
  String? description;
  String? hourRate;
  Image? image;
  String? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;

  SubCategory({
    this.id,
    this.name,
    this.description,
    this.hourRate,
    this.image,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      hourRate: json['hourRate'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      categoryId: json['categoryId'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
    );
  }
}

class ServiceTask {
  String? task;
  String? id;

  ServiceTask({
    this.task,
    this.id,
  });

  factory ServiceTask.fromJson(Map<String, dynamic> json) {
    return ServiceTask(
      task: json['task'],
      id: json['_id'],
    );
  }
}