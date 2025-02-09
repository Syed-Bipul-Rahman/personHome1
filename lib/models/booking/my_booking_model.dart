class Booking {
  User? user;
  String? description;
  Category? categoryId;
  SubCategory? subcategoryId;
  List<ServiceTask>? serviceTasks;
  String? status;
  num? workTime;
  num? totalAmount;
  num? hourRate;
  String? paymentStatus;
  User? acceptBy;
  String? id;
  String? createdAt;
  String? updatedAt;

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
    this.acceptBy,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    user: json['user'] != null ? User.fromJson(json['user']) : null,
    description: json['description'],
    categoryId: json['categoryId'] != null
        ? Category.fromJson(json['categoryId'])
        : null,
    subcategoryId: json['subcategory_Id'] != null
        ? SubCategory.fromJson(json['subcategory_Id'])
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
    acceptBy:
    json['acceptBy'] != null ? User.fromJson(json['acceptBy']) : null,
    id: json['id'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );
}

class User {
  Location? location;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  ImageData? image;
  String? role;
  num? rand;
  List<dynamic>? interest;
  bool? isEmailVerified;
  bool? isResetPassword;
  bool? isInterest;
  bool? isProfileCompleted;
  bool? isDeleted;
  String? oneTimeCode;
  String? fcmToken;
  String? category;
  num? phone;
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

  factory User.fromJson(Map<String, dynamic> json) => User(
    location:
    json['location'] != null ? Location.fromJson(json['location']) : null,
    firstName: json['firstName'],
    lastName: json['lastName'],
    fullName: json['fullName'],
    email: json['email'],
    image: json['image'] != null && json['image'] is Map
        ? ImageData.fromJson(json['image'])
        : null,
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

class Location {
  String? type;
  List<double>? coordinates;
  String? locationName;

  Location({this.type, this.coordinates, this.locationName});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json['type'],
    coordinates: (json['coordinates'] as List?)
        ?.map((e) => e is num ? e.toDouble() : 0.0)
        .toList(),
    locationName: json['locationName'],
  );
}

class ImageData {
  String? url;
  String? path;

  ImageData({this.url, this.path});

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
    url: json['url'],
    path: json['path'],
  );
}

class Category {
  String? category;
  String? description;
  ImageData? image;
  List<String>? subCategories;
  String? id;
  String? createdAt;
  String? updatedAt;

  Category({
    this.category,
    this.description,
    this.image,
    this.subCategories,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    category: json['category'],
    description: json['description'],
    image: json['image'] != null ? ImageData.fromJson(json['image']) : null,
    subCategories:
    (json['subCategories'] as List?)?.map((e) => e.toString()).toList(),
    id: json['id'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );
}

class SubCategory {
  String? id;
  String? name;
  String? description;
  String? hourRate;
  ImageData? image;
  String? categoryId;
  String? createdAt;
  String? updatedAt;
  int? version;

  SubCategory({
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

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json['_id'],
    name: json['name'],
    description: json['description'],
    hourRate: json['hourRate'],
    image: json['image'] != null ? ImageData.fromJson(json['image']) : null,
    categoryId: json['categoryId'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    version: json['__v'],
  );
}

class ServiceTask {
  String? task;
  String? id;

  ServiceTask({this.task, this.id});

  factory ServiceTask.fromJson(Map<String, dynamic> json) => ServiceTask(
    task: json['task'],
    id: json['_id'],
  );
}