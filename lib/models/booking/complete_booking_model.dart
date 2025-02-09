class CompleteBookingModel {
  User user;
  String description;
  Category categoryId;
  Subcategory subcategoryId;
  List<ServiceTask> serviceTasks;
  String status;
  num workTime;
  num totalAmount;
  num hourRate;
  String paymentStatus;
  User acceptBy;
  String id;

  CompleteBookingModel({
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
    required this.acceptBy,
    required this.id,
  });

  factory CompleteBookingModel.fromJson(Map<String, dynamic> json) {
    return CompleteBookingModel(
      user: User.fromJson(json['user']),
      description: json['description'],
      categoryId: Category.fromJson(json['categoryId']),
      subcategoryId: Subcategory.fromJson(json['subcategory_Id']),
      serviceTasks: (json['serviceTasks'] as List)
          .map((task) => ServiceTask.fromJson(task))
          .toList(),
      status: json['status'],
      workTime: json['workTime'],
      totalAmount: json['totalAmount'],
      hourRate: json['hourRate'],
      paymentStatus: json['paymentStatus'],
      acceptBy: User.fromJson(json['acceptBy']),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'description': description,
      'categoryId': categoryId.toJson(),
      'subcategory_Id': subcategoryId.toJson(),
      'serviceTasks': serviceTasks.map((task) => task.toJson()).toList(),
      'status': status,
      'workTime': workTime,
      'totalAmount': totalAmount,
      'hourRate': hourRate,
      'paymentStatus': paymentStatus,
      'acceptBy': acceptBy.toJson(),
      'id': id,
    };
  }
}

class User {
  String firstName;
  String lastName;
  String email;
  String role;
  String id;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      role: json['role'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role,
      'id': id,
    };
  }
}

class Category {
  String category;
  String description;
  String id;

  Category({
    required this.category,
    required this.description,
    required this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      category: json['category'],
      description: json['description'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'description': description,
      'id': id,
    };
  }
}

class Subcategory {
  String id;
  String name;
  String description;
  String hourRate;

  Subcategory({
    required this.id,
    required this.name,
    required this.description,
    required this.hourRate,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      hourRate: json['hourRate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'hourRate': hourRate,
    };
  }
}

class ServiceTask {
  String task;
  String id;

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
