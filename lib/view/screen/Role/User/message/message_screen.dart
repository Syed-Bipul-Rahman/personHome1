import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:home_health_app/controller/chat_controller.dart';
import 'package:home_health_app/helpers/prefs_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../helpers/route.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_drawer.dart';
import '../../../../base/custom_page_loading.dart';
import '../../../BottomMenuBar/caregiver_bottom_menubar.dart';
import '../../../BottomMenuBar/user_bottom_menu.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final ChatController chatController = Get.put(ChatController());
  var userRole = '';

  @override
  void initState() {
    super.initState();
    chatController.fetchChatList();
    getUserRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  drawer: CustomNavigationDrawer(),
      bottomNavigationBar:
      userRole =='user' ?
      const UserBottomNavigationBar(2): const CaregiverBottomNavigationBar(2),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Row(
              children: [
                Container(
                  height: 20.sp,
                  width: 8.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: AppColors.secondaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppStrings.message,
                    style: AppStyles.fontSize20(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Obx(() {
                if (chatController.isLoading.value) {
                  // Show Loading Indicator
                  return const Center(
                    child: CustomPageLoading(),
                  );
                } else if (chatController.chatListPerticipants.isEmpty) {
                  // Show "No message found"
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10.0),
                        Text(
                          "No message found",
                          style: AppStyles.fontSize16(
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyColor,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Show Chat List
                  return ListView.builder(
                    itemCount: chatController.chatListPerticipants.length,
                    itemBuilder: (context, index) {
                      var message = chatController.chatListPerticipants[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.messageInboxScreen,
                                arguments: {
                                  "receiverId": message.participantId,
                                  "senderName": message.firstName,
                                  "receiverRole": message.role,
                                  "receiverImage": AppImages.userImage,
                                  "chatId": message.chatId,
                                });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.hintColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 50.0,
                                      backgroundImage:
                                          AssetImage(AppImages.placeholder),
                                    ),
                                  ),
                                  SizedBox(width: 20.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message.firstName,
                                        style: AppStyles.fontSize18(
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        message.email,
                                        style: AppStyles.fontSize16(
                                          color: AppColors.greyColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                AppStrings.oneMinute,
                                style: AppStyles.fontSize18(
                                  color: AppColors.greyColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  void getUserRole() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var role = preferences.getString(AppStrings.userRole) ?? "";
    setState(() {
      userRole = role;
    });
  }
}
