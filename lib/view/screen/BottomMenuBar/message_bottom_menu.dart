import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../base/custom_text_field.dart';

class MessageBottomMenu extends StatefulWidget {
  const MessageBottomMenu({super.key});

  @override
  State<MessageBottomMenu> createState() => _MessageBottomMenuState();
}

class _MessageBottomMenuState extends State<MessageBottomMenu> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.camera_alt, color: AppColors.primaryColor),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.mic, color: AppColors.primaryColor),
            ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(
                      //   'Send Messages',
                      //   style: TextStyle(color: Colors.grey, fontSize: 16),
                      // ),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Send Messages',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,

                        ),
                      ),
                      const Icon(Icons.send, color: AppColors.primaryColor),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.attach_file, color: AppColors.primaryColor),
            ),
            const Icon(Icons.thumb_up, color: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }
}
