class BookingDetailsModel {
  UserModel? user;
  String? description;
  CategoryModel? category;
  SubCategoryModel? subcategory;
  List<ServiceTaskModel>? serviceTasks;
  String? status;
  num? workTime;
  num? totalAmount;
  num? hourRate;
  String? paymentStatus;
  UserModel? acceptBy;

  BookingDetailsModel({
    this.user,
    this.description,
    this.category,
    this.subcategory,
    this.serviceTasks,
    this.status,
    this.workTime,
    this.totalAmount,
    this.hourRate,
    this.paymentStatus,
    this.acceptBy,
  });

  BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    description = json['description'];
    category = json['categoryId'] != null ? CategoryModel.fromJson(json['categoryId']) : null;
    subcategory = json['subcategory_Id'] != null ? SubCategoryModel.fromJson(json['subcategory_Id']) : null;

    if (json['serviceTasks'] != null) {
      serviceTasks = List<ServiceTaskModel>.from(
          json['serviceTasks'].map((x) => ServiceTaskModel.fromJson(x))
      );
    }

    status = json['status'];
    workTime = json['workTime'] ?? 0;
    totalAmount = json['totalAmount'] ?? 0;
    hourRate = json['hourRate'] ?? 0;
    paymentStatus = json['paymentStatus'];
    acceptBy = json['acceptBy'] != null ? UserModel.fromJson(json['acceptBy']) : null;
  }
}

class UserModel {
  LocationModel? location;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  ImageModel? image;
  String? role;
  List<dynamic>? interest;
  String? fcmToken;
  bool? isEmailVerified;
  bool? isDeleted;

  UserModel({
    this.location,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.image,
    this.role,
    this.interest,
    this.fcmToken,
    this.isEmailVerified,
    this.isDeleted,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? LocationModel.fromJson(json['location']) : null;
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'] ?? '';
    email = json['email'];
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
    role = json['role'];
    interest = json['interest'] ?? [];
    fcmToken = json['fcmToken'];
    isEmailVerified = json['isEmailVerified'] ?? false;
    isDeleted = json['isDeleted'] ?? false;
  }
}

class LocationModel {
  String? type;
  List<double>? coordinates;
  String? locationName;

  LocationModel({this.type, this.coordinates, this.locationName});

  LocationModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'] != null
        ? List<double>.from(json['coordinates'].map((x) => x as double))
        : null;
    locationName = json['locationName'];
  }
}

class ImageModel {
  String? url;
  String? path;

  ImageModel({this.url, this.path});

  ImageModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    path = json['path'];
  }
}

class CategoryModel {
  String? category;
  String? description;
  ImageModel? image;
  List<String>? subCategories;

  CategoryModel({
    this.category,
    this.description,
    this.image,
    this.subCategories,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    description = json['description'];
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
    subCategories = json['subCategories'] != null
        ? List<String>.from(json['subCategories'].map((x) => x))
        : null;
  }
}

class SubCategoryModel {
  String? id;
  String? name;
  String? description;
  String? hourRate;
  ImageModel? image;
  String? categoryId;

  SubCategoryModel({
    this.id,
    this.name,
    this.description,
    this.hourRate,
    this.image,
    this.categoryId,
  });

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? json['id'];
    name = json['name'];
    description = json['description'];
    hourRate = json['hourRate'];
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
    categoryId = json['categoryId'];
  }
}

class ServiceTaskModel {
  String? task;
  String? id;

  ServiceTaskModel({this.task, this.id});

  ServiceTaskModel.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    id = json['_id'];
  }
}