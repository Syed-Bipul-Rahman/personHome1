class CaregiverTrainingModel {
  final String trainingName;
  final Media media;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;

  CaregiverTrainingModel({
    required this.trainingName,
    required this.media,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory CaregiverTrainingModel.fromJson(Map<String, dynamic> json) {
    return CaregiverTrainingModel(
      trainingName: json['trainingName'] as String,
      media: Media.fromJson(json['media'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      id: json['id'] as String,
    );
  }
}

class Media {
  final File file;

  Media({
    required this.file,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      file: File.fromJson(json['file'] as Map<String, dynamic>),
    );
  }
}

class File {
  final String url;
  final String path;

  File({
    required this.url,
    required this.path,
  });

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      url: json['url'] as String,
      path: json['path'] as String,
    );
  }
}