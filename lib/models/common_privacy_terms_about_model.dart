import 'dart:convert';

class PrivacyPolicyResponse {
  final int code;
  final String message;
  final PrivacyPolicyData data;

  PrivacyPolicyResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory PrivacyPolicyResponse.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyResponse(
      code: json['code'],
      message: json['message'],
      data: PrivacyPolicyData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class PrivacyPolicyData {
  final PrivacyPolicyAttributes attributes;

  PrivacyPolicyData({required this.attributes});

  factory PrivacyPolicyData.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyData(
      attributes: PrivacyPolicyAttributes.fromJson(json['attributes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attributes': attributes.toJson(),
    };
  }
}

class PrivacyPolicyAttributes {
  final String id;
  final String text;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  PrivacyPolicyAttributes({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory PrivacyPolicyAttributes.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyAttributes(
      id: json['_id'],
      text: json['text'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}

// Example usage:
// final jsonString = '...'; // Your JSON string
// final response = PrivacyPolicyResponse.fromJson(jsonDecode(jsonString));
// print(response.data.attributes.text);
