import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_health_app/controller/chat_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../service/api_constants.dart';
import '../../../../../service/chat_service.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../base/custom_drawer.dart';
import '../../../../base/custom_text.dart';

class MessageInboxScreen extends StatefulWidget {
  const MessageInboxScreen({super.key});

  @override
  State<MessageInboxScreen> createState() => _MessageInboxScreenState();
}

class _MessageInboxScreenState extends State<MessageInboxScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController messageTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatController _chatController = Get.put(ChatController());
  late final ChatService _chatService;

  // Convert these to RxString for reactive state management
  final _userName = ''.obs;
  final _receiverId = ''.obs;
  final _chatId = ''.obs;
  final _currentUserId = ''.obs;
  final _isSendButtonEnabled = false.obs;

  bool get isMounted => mounted;

  Future<void> _loadUserId() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? savedUserId = prefs.getString(AppStrings.userId);
      if (savedUserId != null && isMounted) {
        _currentUserId.value = savedUserId;
      }
    } catch (e) {
      debugPrint('Error loading user ID: $e');
    }
  }

  void _initializeChatService() {
    _chatService = ChatService();
    if (_chatId.value.isNotEmpty) {
      _chatService.connect(chatId: _chatId.value);
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _handleSendMessage() {
    if (_isSendButtonEnabled.value) {
      final messageText = messageTextController.text.trim();
      if (messageText.isNotEmpty) {
        _chatService.sendMessage(messageText, _chatId.value);
        messageTextController.clear();
        _isSendButtonEnabled.value = false;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // Get arguments safely
    final arguments = Get.arguments;
    if (arguments != null) {
      _userName.value = arguments['senderName'] ?? '';
      _receiverId.value = arguments['receiverId'] ?? '';
      _chatId.value = arguments['chatId'] ?? '';
    }

    _loadUserId();
    _chatController.messageList.clear();
    _initializeChatService();

    // Initialize chat messages
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_chatId.value.isNotEmpty) {
        _chatController.fetchMessages(_chatId.value);
      }
    });

    // Listen for text changes
    messageTextController.addListener(() {
      _isSendButtonEnabled.value = messageTextController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    messageTextController.removeListener(() {});
    messageTextController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    _chatService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => CustomText(
          text: _userName.value,
          fontSize: 18.sp,
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w600,
        )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.w),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(
                    () {
                  if (_chatController.isChatListLoading.value) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CupertinoActivityIndicator(
                          radius: 32.0,
                          color: CupertinoColors.activeBlue,
                        ),
                      ],
                    );
                  }

                  if (_chatController.messageList.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: _chatController.messageList.length,
                    itemBuilder: (context, index) {
                      final message = _chatController.messageList[index];
                      final isCurrentUser = message.sender.id == _currentUserId.value;

                      return Row(
                        mainAxisAlignment: isCurrentUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (!isCurrentUser)
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage(
                                    ApiConstants.baseUrl + message.sender.image.url),
                              ),
                            ),
                          const SizedBox(width: 6),
                          ChatBubble(
                            clipper: ChatBubbleClipper3(
                              type: isCurrentUser
                                  ? BubbleType.sendBubble
                                  : BubbleType.receiverBubble,
                            ),
                            alignment: Alignment.topRight,
                            margin: const EdgeInsets.only(top: 20),
                            backGroundColor: isCurrentUser
                                ? AppColors.primaryColor
                                : AppColors.lightPinkColor,
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Text(
                                message.content,
                                style: TextStyle(
                                  color: isCurrentUser
                                      ? AppColors.whiteColor
                                      : AppColors.dividerColor,
                                ),
                              ),
                            ),
                          ),
                          if (isCurrentUser) const SizedBox(width: 6),
                          if (isCurrentUser)
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage(
                                    ApiConstants.baseUrl + message.sender.image.url),
                              ),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: messageTextController,
                              decoration: const InputDecoration(
                                hintText: 'Type a message',
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.text,
                              focusNode: _focusNode,
                            ),
                          ),
                          Obx(() => InkWell(
                            onTap: _isSendButtonEnabled.value ? _handleSendMessage : null,
                            child: Icon(
                              Icons.send,
                              color: _isSendButtonEnabled.value
                                  ? AppColors.primaryColor
                                  : Colors.grey,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}