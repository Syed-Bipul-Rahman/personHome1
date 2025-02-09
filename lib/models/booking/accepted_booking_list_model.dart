class AcceptedBookingModel {
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

  AcceptedBookingModel({
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

  factory AcceptedBookingModel.fromJson(Map<String, dynamic> json) {
    return AcceptedBookingModel(
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
      acceptBy: AcceptBy.fromJson(json['acceptBy']),
      id: json['id'],
    );
  }

}

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String id;

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
  final String category;
  final String description;
  final String id;

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
  final String id;
  final String name;
  final String description;
  final String hourRate;

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

class AcceptBy {
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String id;

  AcceptBy({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.id,
  });

  factory AcceptBy.fromJson(Map<String, dynamic> json) {
    return AcceptBy(
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
