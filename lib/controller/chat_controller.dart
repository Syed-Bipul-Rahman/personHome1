import 'package:get/get.dart';
import 'package:home_health_app/models/ChatModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/inbox_message_model.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_strings.dart';

class ChatController extends GetxController {
  RxList<ParticipantMessage> chatListPerticipants = <ParticipantMessage>[].obs;
  RxBool isLoading = false.obs;
  RxList<MessageAttributes> messageList = <MessageAttributes>[].obs;

  RxBool isChatListLoading = false.obs;



  void addMessage(MessageAttributes message) {
    messageList.add(message);
    print("Message added: ${message.content}");
    print("Updated message list length: ${messageList.length}");
  }

  void addChatList(ParticipantMessage chat) {
    chatListPerticipants.add(chat);
  }

  void removeChatList(int index) {
    chatListPerticipants.removeAt(index);
  }

  void updateChatList(int index, ParticipantMessage chat) {
    chatListPerticipants[index] = chat;
  }

  //fetch chat list
  fetchChatList() async {
    isLoading.value = true;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);
    final String? userId = prefs.getString(AppStrings.userId);

    if (accessToken == null) {
      Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
      isLoading.value = false;
      return;
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var response = await ApiClient.getData(
      ApiConstants.chatListEndPoint,
      headers: headers,
    );

    if (response.statusCode == 200) {
      try {
        var jsonResponse = response.body;

        if (jsonResponse is Map<String, dynamic>) {
          var chatListResponse = ChatListResponse.fromJson(jsonResponse);

          chatListPerticipants.clear();

          for (var chatAttribute in chatListResponse.data.attributes) {
            for (var participant in chatAttribute.participants) {
              ParticipantMessage message = ParticipantMessage(
                participantId: participant.id,
                firstName: participant.firstName,
                lastName: participant.lastName,
                email: participant.email,
                role: participant.role,
                chatId: chatAttribute.id,
              );

              if (participant.id == userId) {
                continue;
              } else {
                chatListPerticipants.add(message);
              }
            }
          }

          // Debugging: Print all participants
          print("Total participants added: ${chatListPerticipants.length}");
          for (var p in chatListPerticipants) {
            print("Participant ID: ${p.participantId}, Email: ${p.email}");
          }
        } else {
          Get.snackbar(
              AppStrings.errorTextSpecial.tr, "Invalid response format");
        }
      } catch (e) {
        Get.snackbar(
            AppStrings.errorTextSpecial.tr, "Error parsing response: $e");
      }
    } else {
      // var message = response.body['message'] ?? "Unknown error";
      Get.snackbar(AppStrings.errorTextSpecial.tr, "Error fetching chat list");
      isLoading.value = false;
    }

    isLoading.value = false;
  }

  //fetch messages

  fetchMessages(String chatId) async {
    isChatListLoading.value = true;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);

    if (accessToken == null) {
      Get.snackbar(AppStrings.errorTextSpecial.tr, "Unauthorized access");
      isChatListLoading.value = false;
      return;
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var response = await ApiClient.getData(
      "${ApiConstants.allMessageEndPoint}/$chatId",
      headers: headers,
    );

    if (response.statusCode == 200) {
      try {
        var jsonResponse = response.body;

        if (jsonResponse is Map<String, dynamic>) {
          var messageResponse = MessageResponse.fromJson(jsonResponse);

          // Update the reactive list
          messageList.value = messageResponse.data.attributes;
          isChatListLoading.value = false;
          update();


        } else {
          Get.snackbar(
              AppStrings.errorTextSpecial.tr, response.body['message']);
        }
      } catch (e) {
        Get.snackbar(
            AppStrings.errorTextSpecial.tr, "Error parsing response: $e");
      }
    } else {
      Get.snackbar(AppStrings.errorTextSpecial.tr, response.body['message']);
    }

    isChatListLoading.value = false;
  }
}
