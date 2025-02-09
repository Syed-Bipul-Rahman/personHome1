class UserInfoModel {
  UserInfoModel({
    this.lastName,
    this.image,
    this.role,
    this.isInterest,
    this.fullName,
    this.isResetPassword,
    this.isEmailVerified,
    this.rand,
    this.firstName,
    this.isDeleted,
    this.interest,
    this.location,
    this.id,
    this.category,
    this.fcmToken,
    this.email,
    this.isProfileCompleted,
    this.phoneNumber,
    this.dataOfBirth,
    this.gender,
    this.address,
    this.oneTimeCode,
  });

  String? lastName;
  Image? image;
  String? role;
  bool? isInterest;
  String? fullName;
  bool? isResetPassword;
  bool? isEmailVerified;
  int? rand;
  String? firstName;
  bool? isDeleted;
  List<dynamic>? interest;
  Location? location;
  String? id;
  String? category;
  String? fcmToken;
  String? email;
  bool? isProfileCompleted;
  dynamic phoneNumber; // To handle both String and int
  String? dataOfBirth; // Can be updated to DateTime? if required
  String? gender;
  String? address;
  String? oneTimeCode; // Newly added field

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    lastName: json["lastName"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    role: json["role"],
    isInterest: json["isInterest"],
    fullName: json["fullName"],
    isResetPassword: json["isResetPassword"],
    isEmailVerified: json["isEmailVerified"],
    rand: json["rand"],
    firstName: json["firstName"],
    isDeleted: json["isDeleted"],
    interest: json["interest"] == null
        ? null
        : List<dynamic>.from(json["interest"].map((x) => x)),
    location: json["location"] == null
        ? null
        : Location.fromJson(json["location"]),
    id: json["id"],
    category: json["category"],
    fcmToken: json["fcmToken"],
    email: json["email"],
    isProfileCompleted: json["isProfileCompleted"],
    phoneNumber: json["phone"],
    dataOfBirth: json["dataOfBirth"],
    gender: json["gender"],
    address: json["address"],
    oneTimeCode: json["oneTimeCode"],
  );
}

class Image {
  Image({
    required this.path,
    required this.url,
  });

  String path;
  String url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    path: json["path"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "url": url,
  };
}

class Location {
  Location({
    required this.locationName,
    required this.coordinates,
    required this.type,
  });

  String locationName;
  List<double> coordinates;
  String type;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    locationName: json["locationName"],
    coordinates:
    List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "locationName": locationName,
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    "type": type,
  };
}
