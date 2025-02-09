import 'dart:convert';

class SingleTrainingResponse {
  final int code;
  final String message;
  final TrainingAttributes data;

  SingleTrainingResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory SingleTrainingResponse.fromJson(Map<String, dynamic> json) {
    return SingleTrainingResponse(
      code: json['code'],
      message: json['message'],
      data: TrainingAttributes.fromJson(json['data']),
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

class TrainingAttributes {
  final Attributes attributes;

  TrainingAttributes({required this.attributes});

  factory TrainingAttributes.fromJson(Map<String, dynamic> json) {
    return TrainingAttributes(
      attributes: Attributes.fromJson(json['attributes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attributes': attributes.toJson(),
    };
  }
}

class Attributes {
  final Media media;
  final String category;
  final String id;

  Attributes({
    required this.media,
    required this.category,
    required this.id,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      media: Media.fromJson(json['media']),
      category: json['category'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'media': media.toJson(),
      'category': category,
      'id': id,
    };
  }
}

class Media {
  final File file;

  Media({required this.file});

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      file: File.fromJson(json['file']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'file': file.toJson(),
    };
  }
}

class File {
  final String url;
  final String path;

  File({required this.url, required this.path});

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
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
