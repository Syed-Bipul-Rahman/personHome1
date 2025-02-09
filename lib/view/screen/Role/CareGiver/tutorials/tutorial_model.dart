class Tutorial {
  final Media media;
  final String tutorialName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;

  Tutorial({
    required this.media,
    required this.tutorialName,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  // Factory method to parse JSON into a Tutorial object
  factory Tutorial.fromJson(Map<String, dynamic> json) {
    return Tutorial(
      media: Media.fromJson(json['media']),
      tutorialName: json['tutorialName'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      id: json['id'],
    );
  }
}

class Media {
  final File file;

  Media({required this.file});

  // Factory method to parse JSON into a Media object
  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      file: File.fromJson(json['file']),
    );
  }
}

class File {
  final String url;
  final String path;

  File({required this.url, required this.path});

  // Factory method to parse JSON into a File object
  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      url: json['url'],
      path: json['path'],
    );
  }
}