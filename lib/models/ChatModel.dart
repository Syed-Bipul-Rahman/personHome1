class ChatListResponse {
  final int code;
  final String message;
  final Data data;

  ChatListResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ChatListResponse.fromJson(Map<String, dynamic> json) {
    return ChatListResponse(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? Data.fromJson(json['data']) : Data(attributes: []),
    );
  }
}

class Data {
  final List<ChatAttributes> attributes;

  Data({required this.attributes});

  factory Data.fromJson(Map<String, dynamic> json) {
    var list = json['attributes'] as List<dynamic>? ?? [];
    List<ChatAttributes> attributesList =
    list.map((item) => ChatAttributes.fromJson(item)).toList();
    return Data(attributes: attributesList);
  }
}

class ChatAttributes {
  final String id;
  final List<Participant> participants;
  final bool isAdminChat;
  final Participant admin;
  final String createdAt;
  final String updatedAt;

  ChatAttributes({
    required this.id,
    required this.participants,
    required this.isAdminChat,
    required this.admin,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatAttributes.fromJson(Map<String, dynamic> json) {
    var participantsList = json['participants'] as List<dynamic>? ?? [];
    List<Participant> participants = participantsList
        .map((item) => Participant.fromJson(item as Map<String, dynamic>))
        .toList();

    return ChatAttributes(
      id: json['_id'] ?? '',
      participants: participants,
      isAdminChat: json['isAdminChat'] ?? false,
      admin: json['admin'] != null
          ? Participant.fromJson(json['admin'])
          : Participant.empty(),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class Participant {
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String id;

  Participant({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.id,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      id: json['id'] ?? '',
    );
  }

  // Return an empty Participant object for null safety
  factory Participant.empty() {
    return Participant(
      firstName: '',
      lastName: '',
      email: '',
      role: '',
      id: '',
    );
  }
}

class ParticipantMessage {
  final String participantId;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String chatId;

  ParticipantMessage({
    required this.participantId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.chatId,
  });
}
