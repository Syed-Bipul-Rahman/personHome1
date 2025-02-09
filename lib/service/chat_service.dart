import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../controller/chat_controller.dart';
import '../models/inbox_message_model.dart';
import '../utils/app_strings.dart';
import 'api_checker.dart';
import 'api_client.dart';
import 'api_constants.dart';

class ChatService {
  late IO.Socket socket;

  RxBool signUpLoading = false.obs;

  // Initialize the socket connection
  void connect({required String chatId}) {
    socket = IO.io(
      'http://10.0.60.203:8181',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    socket.connect();

    // Connection successful
    socket.onConnect((_) {
      print('Socket connected successfully');
    });

    socket.on('messages::$chatId', (data) {
      print('Received response: $data');

      Map<String, dynamic> firstJson = data;
      Map<String, dynamic> secondJson = transformToSecondJsonFormat(firstJson);

      // Get the chat controller
      final chatController = Get.put(ChatController());

      // Check for message duplication
      final newMessage = MessageAttributes.fromJson(secondJson['data']['attributes'][0]);
      if (!chatController.messageList.any((msg) => msg.id == newMessage.id)) {
        // Add the message to the list if it's not a duplicate
        chatController.addMessage(newMessage);
      } else {
        print("Duplicate message ignored: ${newMessage.id}");
      }
    });

    // Handle errors
    socket.onConnectError((error) {
      print('Connection Error: $error');
    });

    socket.onError((error) {
      print('Error: $error');
    });

    // Handle disconnection
    socket.onDisconnect((_) {
      print('Socket disconnected');
    });

    // Auto-reconnection logic
    socket.onReconnect((_) {
      print('Reconnected to the server');
    });

    socket.onReconnectAttempt((_) {
      print('Attempting to reconnect...');
    });
  }

  // Send a message to the server
  sendMessage(String content, String chatId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString(AppStrings.accessToken);

    signUpLoading.value = true;
    Map<String, String> body = {"content": content, "chatId": chatId};

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var response = await ApiClient.postData(
      ApiConstants.sentMessageEndPoint,
      jsonEncode(body),
      headers: headers,
    );

    print("===============>>Api response : ${response.statusCode}");

    if (response.statusCode == 200) {
      var msgResponse = response.body['data']['attributes']['content'];
      var chatId = response.body['data']['attributes']['chat'];
      print("message sent to chatId : $chatId");
      print("===============>>user message : $msgResponse");
    } else if (response.statusCode == 409) {
      Get.snackbar(AppStrings.errorTextSpecial.tr, response.body['message']);
    } else {
      ApiChecker.checkApi(response);
      Get.snackbar(AppStrings.errorTextSpecial.tr, response.body['message']);
    }
    signUpLoading.value = false;
  }

  // Close the socket connection
  void disconnect() {
    if (socket.connected) {
      // Remove all listeners to prevent memory leaks
      socket.clearListeners();

      // Disconnect the socket
      socket.disconnect();
      print("Socket connection closed and listeners removed.");
    } else {
      print("Socket is already disconnected or was never connected.");
    }
  }

  // Method to transform the JSON format
  Map<String, dynamic> transformToSecondJsonFormat(
      Map<String, dynamic> firstJson) {
    final attributes = firstJson['data']['attributes'];

    attributes['receiver'] = '';

    final transformedJson = {
      'code': firstJson['code'],
      'message': 'transformed message successfully',
      'data': {
        'attributes': [attributes]
      }
    };

    return transformedJson;
  }
}
