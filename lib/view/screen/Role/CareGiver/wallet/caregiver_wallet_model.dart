class CareGiverWalletModel {
  final num? balance;
  final num? total;
  final List<Voucher>? vouchers;

  CareGiverWalletModel({
    this.balance,
    this.total,
    this.vouchers,
  });

  factory CareGiverWalletModel.fromJson(Map<String, dynamic> json) {
    return CareGiverWalletModel(
      balance: json['balance'],
      total: json['total'],
      vouchers: (json['vouchers'] as List)
          .map((voucher) => Voucher.fromJson(voucher))
          .toList(),
    );
  }
}

class Voucher {
  final num amount;
  final Booking bookingId;
  final num hourlyRate;
  final num workTime;
  final String date;
  final String id;

  Voucher({
    required this.amount,
    required this.bookingId,
    required this.hourlyRate,
    required this.workTime,
    required this.date,
    required this.id,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      amount: json['amount'],
      bookingId: Booking.fromJson(json['bookingId']),
      hourlyRate: json['hourlyRate'],
      workTime: json['workTime'],
      date: json['date'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'bookingId': bookingId.toJson(),
      'hourlyRate': hourlyRate,
      'workTime': workTime,
      'date': date,
      '_id': id,
    };
  }
}

class Booking {
  final String user;
  final String description;
  final String categoryId;
  final String subcategoryId;
  final List<ServiceTask> serviceTasks;
  final String status;
  final num workTime;
  final num totalAmount;
  final num hourRate;
  final String paymentStatus;
  final String acceptBy;
  final String id;

  Booking({
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

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      user: json['user'],
      description: json['description'],
      categoryId: json['categoryId'],
      subcategoryId: json['subcategory_Id'],
      serviceTasks: (json['serviceTasks'] as List)
          .map((task) => ServiceTask.fromJson(task))
          .toList(),
      status: json['status'],
      workTime: json['workTime'],
      totalAmount: json['totalAmount'],
      hourRate: json['hourRate'],
      paymentStatus: json['paymentStatus'],
      acceptBy: json['acceptBy'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'description': description,
      'categoryId': categoryId,
      'subcategory_Id': subcategoryId,
      'serviceTasks': serviceTasks.map((task) => task.toJson()).toList(),
      'status': status,
      'workTime': workTime,
      'totalAmount': totalAmount,
      'hourRate': hourRate,
      'paymentStatus': paymentStatus,
      'acceptBy': acceptBy,
      'id': id,
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