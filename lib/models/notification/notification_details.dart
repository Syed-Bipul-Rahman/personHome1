class UserNotificationDetailsModel {
  String? categoryId;
  String? userId;
  String? sendBy;
  BookingDetails? bookingDetails;
  String? transactionId;
  String? role;
  String? title;
  String? content;
  String? devStatus;
  String? status;
  bool? isActive;
  String? type;
  String? priority;
  List<dynamic>? serviceTasks;
  String? id;

  UserNotificationDetailsModel({
    this.categoryId,
    this.userId,
    this.sendBy,
    this.bookingDetails,
    this.transactionId,
    this.role,
    this.title,
    this.content,
    this.devStatus,
    this.status,
    this.isActive,
    this.type,
    this.priority,
    this.serviceTasks,
    this.id,
  });

  factory UserNotificationDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserNotificationDetailsModel(
      categoryId: json['categoryId'],
      userId: json['userId'],
      sendBy: json['sendBy'],
      bookingDetails: json['bookingId'] != null
          ? BookingDetails.fromJson(json['bookingId'])
          : null,
      transactionId: json['transactionId'],
      role: json['role'],
      title: json['title'],
      content: json['content'],
      devStatus: json['devStatus'],
      status: json['status'],
      isActive: json['isActive'],
      type: json['type'],
      priority: json['priority'],
      serviceTasks: json['serviceTasks'],
      id: json['id'],
    );
  }
}

class BookingDetails {
  User? user;
  String? description;
  Category? categoryId;
  Subcategory? subcategoryId;
  List<ServiceTask>? serviceTasks;
  String? status;
  int? workTime;
  int? totalAmount;
  int? hourRate;
  String? paymentStatus;
  String? acceptBy;
  String? id;

  BookingDetails({
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
    this.acceptBy,
    this.id,
  });

  factory BookingDetails.fromJson(Map<String, dynamic> json) {
    return BookingDetails(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      description: json['description'],
      categoryId: json['categoryId'] != null
          ? Category.fromJson(json['categoryId'])
          : null,
      subcategoryId: json['subcategory_Id'] != null
          ? Subcategory.fromJson(json['subcategory_Id'])
          : null,
      serviceTasks: json['serviceTasks'] != null
          ? (json['serviceTasks'] as List)
          .map((e) => ServiceTask.fromJson(e))
          .toList()
          : null,
      status: json['status'],
      workTime: json['workTime'],
      totalAmount: json['totalAmount'],
      hourRate: json['hourRate'],
      paymentStatus: json['paymentStatus'],
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
  int? rand;
  List<dynamic>? interest;
  bool? isEmailVerified;
  bool? isResetPassword;
  bool? isInterest;
  bool? isProfileCompleted;
  bool? isDeleted;
  String? oneTimeCode;
  String? fcmToken;
  String? category;
  int? phone;
  String? address;
  String? dataOfBirth;
  String? gender;
  String? id;
  String? createdAt;
  String? updatedAt;

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
    this.isEmailVerified,
    this.isResetPassword,
    this.isInterest,
    this.isProfileCompleted,
    this.isDeleted,
    this.oneTimeCode,
    this.fcmToken,
    this.category,
    this.phone,
    this.address,
    this.dataOfBirth,
    this.gender,
    this.id,
    this.createdAt,
    this.updatedAt,
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
      isEmailVerified: json['isEmailVerified'],
      isResetPassword: json['isResetPassword'],
      isInterest: json['isInterest'],
      isProfileCompleted: json['isProfileCompleted'],
      isDeleted: json['isDeleted'],
      oneTimeCode: json['oneTimeCode'],
      fcmToken: json['fcmToken'],
      category: json['category'],
      phone: json['phone'],
      address: json['address'],
      dataOfBirth: json['dataOfBirth'],
      gender: json['gender'],
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
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
          ? List<double>.from(json['coordinates'])
          : null,
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

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'path': path,
    };
  }
}

class Category {
  String? category;
  String? description;
  Image? image;
  List<String>? subCategories;
  String? createdAt;
  String? updatedAt;
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
          ? List<String>.from(json['subCategories'])
          : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'description': description,
      'image': image?.toJson(),
      'subCategories': subCategories,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'id': id,
    };
  }
}

class Subcategory {
  String? id;
  String? name;
  String? description;
  String? hourRate;
  Image? image;
  String? categoryId;
  String? createdAt;
  String? updatedAt;
  int? version;

  Subcategory({
    this.id,
    this.name,
    this.description,
    this.hourRate,
    this.image,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      hourRate: json['hourRate'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      categoryId: json['categoryId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'hourRate': hourRate,
      'image': image?.toJson(),
      'categoryId': categoryId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': version,
    };
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