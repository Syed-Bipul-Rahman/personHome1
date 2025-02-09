class CaregiverNotificationJobListModel {
  final String userId;
  final BookingDetails? bookingId;
  final String? categoryId;
  final String? transactionId;
  final String role;
  final String? title;
  final String content;
  final String status;
  final bool isActive;
  final String type;
  final String priority;
  final List<dynamic> serviceTasks;
  final String id;

  CaregiverNotificationJobListModel({
    required this.userId,
    this.bookingId,
    this.categoryId,
    this.transactionId,
    required this.role,
    this.title,
    required this.content,
    required this.status,
    required this.isActive,
    required this.type,
    required this.priority,
    required this.serviceTasks,
    required this.id,
  });

  factory CaregiverNotificationJobListModel.fromJson(Map<String, dynamic> json) {
    return CaregiverNotificationJobListModel(
      userId: json['userId'],
      bookingId: json['bookingId'] != null ? BookingDetails.fromJson(json['bookingId']) : null,
      categoryId: json['categoryId'],
      transactionId: json['transactionId'],
      role: json['role'],
      title: json['title'],
      content: json['content'],
      status: json['status'],
      isActive: json['isActive'],
      type: json['type'],
      priority: json['priority'],
      serviceTasks: json['serviceTasks'] ?? [],
      id: json['id'],
    );
  }
}

class BookingDetails {
  final User user;
  final String description;
  final Category categoryId;
  final Subcategory subcategoryId;
  final List<ServiceTask> serviceTasks;
  final String status;
  final num workTime; // Changed from int to num
  final num totalAmount; // Changed from int to num
  final num hourRate; // Changed from int to num
  final String paymentStatus;
  final String id;

  BookingDetails({
    required this.user,
    required this.description,
    required this.categoryId,
    required this.subcategoryId,
    required this.serviceTasks,
    required this.status,
    required this.workTime,
    required this.totalAmount,
    required this.hourRate,
    required this.paymentStatus,
    required this.id,
  });

  factory BookingDetails.fromJson(Map<String, dynamic> json) {
    return BookingDetails(
      user: User.fromJson(json['user']),
      description: json['description'],
      categoryId: Category.fromJson(json['categoryId']),
      subcategoryId: Subcategory.fromJson(json['subcategory_Id']),
      serviceTasks: (json['serviceTasks'] as List<dynamic>)
          .map((e) => ServiceTask.fromJson(e))
          .toList(),
      status: json['status'],
      workTime: json['workTime'],
      totalAmount: json['totalAmount'],
      hourRate: json['hourRate'],
      paymentStatus: json['paymentStatus'],
      id: json['id'],
    );
  }
}

class User {
  final Location location;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final Image image;
  final String role;
  final bool isEmailVerified;
  final String id;

  User({
    required this.location,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.image,
    required this.role,
    required this.isEmailVerified,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      location: Location.fromJson(json['location']),
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      email: json['email'],
      image: Image.fromJson(json['image']),
      role: json['role'],
      isEmailVerified: json['isEmailVerified'],
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
}

class Subcategory {
  final String id;
  final String name;
  final String description;
  final num hourRate; // Changed from String to num
  final Image image;

  Subcategory({
    required this.id,
    required this.name,
    required this.description,
    required this.hourRate,
    required this.image,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      hourRate: num.tryParse(json['hourRate']) ?? 0, // Convert string to num
      image: Image.fromJson(json['image']),
    );
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
}