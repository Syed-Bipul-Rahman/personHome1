class MessageResponse {
  final int code;
  final String message;
  final MessageData data;

  MessageResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
      code: json['code'] as int,
      message: json['message'] as String,
      data: MessageData.fromJson(json['data']),
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

class MessageData {
  final List<MessageAttributes> attributes;

  MessageData({
    required this.attributes,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      attributes: (json['attributes'] as List)
          .map((e) => MessageAttributes.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attributes': attributes.map((e) => e.toJson()).toList(),
    };
  }
}

class MessageAttributes {
  final Sender sender;
  final String receiver;
  final String chat;
  final String content;
  final String messageType;
  final String id;

  MessageAttributes({
    required this.sender,
    required this.receiver,
    required this.chat,
    required this.content,
    required this.messageType,
    required this.id,
  });

  factory MessageAttributes.fromJson(Map<String, dynamic> json) {
    return MessageAttributes(
      sender: Sender.fromJson(json['sender']),
      receiver: json['receiver'] as String,
      chat: json['chat'] as String,
      content: json['content'] as String,
      messageType: json['messageType'] as String,
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender.toJson(),
      'receiver': receiver,
      'chat': chat,
      'content': content,
      'messageType': messageType,
      'id': id,
    };
  }
}

class Sender {
  final String firstName;
  final String lastName;
  final String fullName;
  final String role;
  final String id;
  final ImageData image;

  Sender({
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.role,
    required this.id,
    required this.image,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      fullName: json['fullName'] as String,
      role: json['role'] as String,
      id: json['id'] as String,
      image: ImageData.fromJson(json['image']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'role': role,
      'id': id,
      'image': image.toJson(),
    };
  }
}

class ImageData {
  final String url;
  final String path;

  ImageData({
    required this.url,
    required this.path,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      url: json['url'] as String,
      path: json['path'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'path': path,
    };
  }
}
