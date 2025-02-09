class Sender {
  final String firstName;
  final String lastName;
  final String fullName;
  final Image image;
  final String role;
  final String id;

  Sender({
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.image,
    required this.role,
    required this.id,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      image: Image.fromJson(json['image']),
      role: json['role'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'image': image.toJson(),
      'role': role,
      'id': id,
    };
  }
}

class Image {
  final String url;
  final String path;

  Image({required this.url, required this.path});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
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

class Message {
  final Sender sender;
  final String chat;
  final String content;
  final String messageType;
  final String id;

  Message({
    required this.sender,
    required this.chat,
    required this.content,
    required this.messageType,
    required this.id,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: Sender.fromJson(json['sender']),
      chat: json['chat'],
      content: json['content'],
      messageType: json['messageType'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender.toJson(),
      'chat': chat,
      'content': content,
      'messageType': messageType,
      'id': id,
    };
  }
}
