import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/app_export.dart';
import 'package:kiwis_flutter/views/chat_room/widgets/send_text.widget.dart';

class SettingChatRoom extends StatelessWidget {
  const SettingChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return ChatRoomContent();
  }
}

class ChatRoomContent extends StatelessWidget {
  const ChatRoomContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: double.maxFinite,
      margin: EdgeInsets.only(top: 32.h),
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Stack(
        children: [
          SizedBox(height: 32.h),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                SendText(isFirst: true),
                SendText(),
                SendText(isLast: true),
                SendText(isMe: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
