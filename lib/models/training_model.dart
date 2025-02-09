class TrainingModel {
  String? trainingName;
  MediaModel? media;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? id;

  TrainingModel({
    this.trainingName,
    this.media,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory TrainingModel.fromJson(Map<String, dynamic> json) {
    return TrainingModel(
      trainingName: json['trainingName'] as String?,
      media: json['media'] != null ? MediaModel.fromJson(json['media']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['trainingName'] = trainingName;
    if (media != null) {
      data['media'] = media!.toJson();
    }
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['id'] = id;
    return data;
  }
}

class MediaModel {
  FileModel? file;

  MediaModel({this.file});

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      file: json['file'] != null ? FileModel.fromJson(json['file']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (file != null) {
      data['file'] = file!.toJson();
    }
    return data;
  }
}

class FileModel {
  String? url;
  String? path;

  FileModel({this.url, this.path});

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      url: json['url'] as String?,
      path: json['path'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = url;
    data['path'] = path;
    return data;
  }
}