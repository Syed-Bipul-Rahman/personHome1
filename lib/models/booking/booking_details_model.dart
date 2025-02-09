class BookingDetails {
  final User? user;
  final String? description;
  final Category? categoryId;
  final Subcategory? subcategoryId;
  final List<ServiceTask>? serviceTasks;
  final String? status;
  final num? workTime;
  final num? totalAmount;
  final num? hourRate;
  final String? paymentStatus;
  final AcceptBy? acceptBy;
  final String? id;

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

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
    user: json['user'] != null ? User.fromJson(json['user']) : null,
    description: json['description'],
    categoryId: json['categoryId'] != null
        ? Category.fromJson(json['categoryId'])
        : null,
    subcategoryId: json['subcategory_Id'] != null
        ? Subcategory.fromJson(json['subcategory_Id'])
        : null,
    serviceTasks: json['serviceTasks'] != null
        ? List<ServiceTask>.from(
        json['serviceTasks'].map((x) => ServiceTask.fromJson(x)))
        : null,
    status: json['status'],
    workTime: json['workTime'],
    totalAmount: json['totalAmount'],
    hourRate: json['hourRate'],
    paymentStatus: json['paymentStatus'],
    acceptBy: json['acceptBy'] != null
        ? AcceptBy.fromJson(json['acceptBy'])
        : null,
    id: json['id'],
  );

  Map<String, dynamic> toJson() => {
    'user': user?.toJson(),
    'description': description,
    'categoryId': categoryId?.toJson(),
    'subcategory_Id': subcategoryId?.toJson(),
    'serviceTasks': serviceTasks?.map((x) => x.toJson()).toList(),
    'status': status,
    'workTime': workTime,
    'totalAmount': totalAmount,
    'hourRate': hourRate,
    'paymentStatus': paymentStatus,
    'acceptBy': acceptBy?.toJson(),
    'id': id,
  };
}

class User {
  final Location? location;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final dynamic image;
  final String? role;
  final num? rand;
  final List<dynamic>? interest;
  final bool? isEmailVerified;
  final bool? isResetPassword;
  final bool? isInterest;
  final bool? isProfileCompleted;
  final bool? isDeleted;
  final dynamic oneTimeCode;
  final String? fcmToken;
  final String? category;
  final num? phone;
  final String? address;
  final String? dataOfBirth;
  final String? gender;
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
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    location: json['location'] != null
        ? Location.fromJson(json['location'])
        : null,
    firstName: json['firstName'],
    lastName: json['lastName'],
    fullName: json['fullName'],
    email: json['email'],
    image: json['image'], // Handle both String and Map
    role: json['role'],
    rand: json['rand'],
    interest: json['interest'] != null
        ? List<dynamic>.from(json['interest'])
        : null,
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
  );

  Map<String, dynamic> toJson() => {
    'location': location?.toJson(),
    'firstName': firstName,
    'lastName': lastName,
    'fullName': fullName,
    'email': email,
    'image': image is Map ? Image.fromJson(image).toJson() : image,
    'role': role,
    'rand': rand,
    'interest': interest,
    'isEmailVerified': isEmailVerified,
    'isResetPassword': isResetPassword,
    'isInterest': isInterest,
    'isProfileCompleted': isProfileCompleted,
    'isDeleted': isDeleted,
    'oneTimeCode': oneTimeCode,
    'fcmToken': fcmToken,
    'category': category,
    'phone': phone,
    'address': address,
    'dataOfBirth': dataOfBirth,
    'gender': gender,
    'id': id,
  };
}

class Location {
  final String? type;
  final List<double>? coordinates;
  final String? locationName;

  Location({
    this.type,
    this.coordinates,
    this.locationName,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json['type'],
    coordinates: json['coordinates'] != null
        ? List<double>.from(json['coordinates'].map((x) => x))
        : null,
    locationName: json['locationName'],
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'coordinates': coordinates,
    'locationName': locationName,
  };
}

class Image {
  final String? url;
  final String? path;

  Image({
    this.url,
    this.path,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    url: json['url'],
    path: json['path'],
  );

  Map<String, dynamic> toJson() => {
    'url': url,
    'path': path,
  };
}

class Category {
  final Image? image;
  final String? category;
  final String? description;
  final List<String>? subCategories;
  final String? id;

  Category({
    this.image,
    this.category,
    this.description,
    this.subCategories,
    this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    image: json['image'] != null ? Image.fromJson(json['image']) : null,
    category: json['category'],
    description: json['description'],
    subCategories: json['subCategories'] != null
        ? List<String>.from(json['subCategories'])
        : null,
    id: json['id'],
  );

  Map<String, dynamic> toJson() => {
    'image': image?.toJson(),
    'category': category,
    'description': description,
    'subCategories': subCategories,
    'id': id,
  };
}

class Subcategory {
  final String? id;
  final String? name;
  final String? description;
  final String? hourRate;
  final Image? image;
  final String? categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;

  Subcategory({
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

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json['_id'],
    name: json['name'],
    description: json['description'],
    hourRate: json['hourRate'],
    image: json['image'] != null ? Image.fromJson(json['image']) : null,
    categoryId: json['categoryId'],
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'])
        : null,
    v: json['__v'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'description': description,
    'hourRate': hourRate,
    'image': image?.toJson(),
    'categoryId': categoryId,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };
}

class ServiceTask {
  final String? task;
  final String? id;

  ServiceTask({
    this.task,
    this.id,
  });

  factory ServiceTask.fromJson(Map<String, dynamic> json) => ServiceTask(
    task: json['task'],
    id: json['_id'],
  );

  Map<String, dynamic> toJson() => {
    'task': task,
    '_id': id,
  };
}

class AcceptBy extends User {
  AcceptBy({
    Location? location,
    String? firstName,
    String? lastName,
    String? fullName,
    String? email,
    dynamic image,
    String? role,
    num? rand,
    List<dynamic>? interest,
    bool? isEmailVerified,
    bool? isResetPassword,
    bool? isInterest,
    bool? isProfileCompleted,
    bool? isDeleted,
    dynamic oneTimeCode,
    String? fcmToken,
    String? category,
    num? phone,
    String? address,
    String? dataOfBirth,
    String? gender,
    String? id,
  }) : super(
    location: location,
    firstName: firstName,
    lastName: lastName,
    fullName: fullName,
    email: email,
    image: image,
    role: role,
    rand: rand,
    interest: interest,
    isEmailVerified: isEmailVerified,
    isResetPassword: isResetPassword,
    isInterest: isInterest,
    isProfileCompleted: isProfileCompleted,
    isDeleted: isDeleted,
    oneTimeCode: oneTimeCode,
    fcmToken: fcmToken,
    category: category,
    phone: phone,
    address: address,
    dataOfBirth: dataOfBirth,
    gender: gender,
    id: id,
  );

  factory AcceptBy.fromJson(Map<String, dynamic> json) => AcceptBy(
    location: json['location'] != null
        ? Location.fromJson(json['location'])
        : null,
    firstName: json['firstName'],
    lastName: json['lastName'],
    fullName: json['fullName'],
    email: json['email'],
    image: json['image'], // Handle both String and Map
    role: json['role'],
    rand: json['rand'],
    interest: json['interest'] != null
        ? List<dynamic>.from(json['interest'])
        : null,
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
  );
}