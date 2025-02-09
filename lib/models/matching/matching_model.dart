class CaregiverMatching {
  final Location? location;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final Image? image;
  final String? role;
  final int? rand;
  final List<dynamic>? interest;
  final String? fcmToken;
  final String? oneTimeCode;
  final bool? isEmailVerified;
  final bool? isResetPassword;
  final bool? isInterest;
  final bool? isProfileCompleted;
  final bool? isDeleted;
  final String? category;
  final String? id;
  final int? phone;

  CaregiverMatching({
    this.location,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.image,
    this.role,
    this.rand,
    this.interest,
    this.fcmToken,
    this.oneTimeCode,
    this.isEmailVerified,
    this.isResetPassword,
    this.isInterest,
    this.isProfileCompleted,
    this.isDeleted,
    this.category,
    this.id,
    this.phone,
  });

  factory CaregiverMatching.fromJson(Map<String, dynamic> json) {
    return CaregiverMatching(
      location: Location.fromJson(json['location']),
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      image: Image.fromJson(json['image']),
      role: json['role'] ?? '',
      rand: json['rand'] ?? 0,
      interest: json['interest'] ?? [],
      fcmToken: json['fcmToken'],
      oneTimeCode: json['oneTimeCode'],
      isEmailVerified: json['isEmailVerified'] ?? false,
      isResetPassword: json['isResetPassword'] ?? false,
      isInterest: json['isInterest'] ?? false,
      isProfileCompleted: json['isProfileCompleted'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      category: json['category'] ?? '',
      id: json['id'] ?? '',
      phone: json['phone'],
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
      type: json['type'] ?? '',
      coordinates: List<double>.from(json['coordinates'] ?? []),
      locationName: json['locationName'] ?? '',
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
      url: json['url'] ?? '',
      path: json['path'] ?? '',
    );
  }
}
