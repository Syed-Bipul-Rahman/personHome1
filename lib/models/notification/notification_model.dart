
class NotificationModel {
  final String? userId;
  final String? sendBy;
  final Booking? bookingId;
  final dynamic categoryId;
  final String? transactionId;
  final String? role;
  final String? content;
  final String? status;
  final bool? isActive;
  final String? type;
  final String? priority;
  final List<ServiceTask>? serviceTasks;
  final String? id;
  final String? title;
  final String? devStatus;

  NotificationModel({
    this.userId,
    this.sendBy,
    this.bookingId,
    this.categoryId,
    this.transactionId,
    this.role,
    this.content,
    this.status,
    this.isActive,
    this.type,
    this.priority,
    this.serviceTasks,
    this.id,
    this.title,
    this.devStatus,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      userId: json['userId'],
      sendBy: json['sendBy'],
      bookingId: json['bookingId'] != null ? Booking.fromJson(json['bookingId']) : null,
      categoryId: json['categoryId'],
      transactionId: json['transactionId'],
      role: json['role'],
      content: json['content'],
      status: json['status'],
      isActive: json['isActive'],
      type: json['type'],
      priority: json['priority'],
      serviceTasks: json['serviceTasks'] != null
          ? (json['serviceTasks'] as List).map((e) => ServiceTask.fromJson(e)).toList()
          : [],
      id: json['id'],
      title: json['title'],
      devStatus: json['devStatus'],
    );
  }
}

class Booking {
  final User? user;
  final String? description;
  final dynamic categoryId;
  final Subcategory? subcategoryId;
  final List<ServiceTask>? serviceTasks;
  final String? status;
  final num? workTime;
  final num? totalAmount;
  final num? hourRate;
  final String? paymentStatus;
  final String? acceptBy;
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
    this.acceptBy,
    this.id,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      description: json['description'],
      categoryId: json['categoryId'],
      subcategoryId: json['subcategory_Id'] != null ? Subcategory.fromJson(json['subcategory_Id']) : null,
      serviceTasks: json['serviceTasks'] != null
          ? (json['serviceTasks'] as List).map((e) => ServiceTask.fromJson(e)).toList()
          : [],
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
  final Location? location;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final Image? image;
  final String? role;
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
    this.phone,
    this.address,
    this.dataOfBirth,
    this.gender,
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
      phone: json['phone'],
      address: json['address'],
      dataOfBirth: json['dataOfBirth'],
      gender: json['gender'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location?.toJson(),
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'email': email,
      'image': image?.toJson(),
      'role': role,
      'phone': phone,
      'address': address,
      'dataOfBirth': dataOfBirth,
      'gender': gender,
      'id': id,
    };
  }
}

class Location {
  final String? type;
  final List<double>? coordinates;
  final String? locationName;

  Location({this.type, this.coordinates, this.locationName});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: json['coordinates']?.cast<double>(),
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

class Subcategory {
  final String? id;
  final String? name;
  final String? description;
  final String? hourRate;
  final Image? image;
  final String? categoryId;

  Subcategory({this.id, this.name, this.description, this.hourRate, this.image, this.categoryId});

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      hourRate: json['hourRate'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      categoryId: json['categoryId'],
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
    };
  }
}

class ServiceTask {
  final String? task;
  final String? id;

  ServiceTask({this.task, this.id});

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

class Image {
  final String? url;
  final String? path;

  Image({this.url, this.path});

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
