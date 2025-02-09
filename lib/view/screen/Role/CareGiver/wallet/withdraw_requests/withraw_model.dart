class Transaction {
  final Caregiver caregiver;
  final String cardholderName;
  final String cardNumber;
  final String cvv;
  final num amount; // Use `num` instead of `int`
  final String code;
  final String status;
  final Image image;
  final String requestedAt;
  final String createdAt;
  final String updatedAt;
  final String? adminNote;
  final String? processedAt;
  final String id;

  Transaction({
    required this.caregiver,
    required this.cardholderName,
    required this.cardNumber,
    required this.cvv,
    required this.amount,
    required this.code,
    required this.status,
    required this.image,
    required this.requestedAt,
    required this.createdAt,
    required this.updatedAt,
    this.adminNote,
    this.processedAt,
    required this.id,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      caregiver: Caregiver.fromJson(json['caregiver']),
      cardholderName: json['cardholderName'],
      cardNumber: json['cardNumber'],
      cvv: json['cvv'],
      amount: json['amount'], // No need for type checking, `num` handles both `int` and `double`
      code: json['code'],
      status: json['status'],
      image: Image.fromJson(json['image']),
      requestedAt: json['requestedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      adminNote: json['adminNote'],
      processedAt: json['processedAt'],
      id: json['id'],
    );
  }
}

class Caregiver {
  final String firstName;
  final String fullName;
  final String email;
  final String id;

  Caregiver({
    required this.firstName,
    required this.fullName,
    required this.email,
    required this.id,
  });

  factory Caregiver.fromJson(Map<String, dynamic> json) {
    return Caregiver(
      firstName: json['firstName'],
      fullName: json['fullName'],
      email: json['email'],
      id: json['id'],
    );
  }
}

class Image {
  final String url;
  final String? path;

  Image({
    required this.url,
    this.path,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      url: json['url'],
      path: json['path'],
    );
  }
}