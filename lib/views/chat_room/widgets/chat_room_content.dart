import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/chat_room/chat_room_controller.dart';
import 'package:kiwis_flutter/views/chat_room/widgets/chat_bubble.widget.dart';

class ChatRoomContent extends GetView<ChatRoomController> {
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
            child: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: controller.group.value.messages!.length,
                itemBuilder: (context, index) {
                  final messages = controller.group.value.messages!;
                  final currentMessage = messages[index];
                  final isGroupStart = index == 0 ||
                      messages[index - 1].senderId != currentMessage.senderId;
                  final isGroupEnd = index == messages.length - 1 ||
                      messages[index + 1].senderId != currentMessage.senderId;

                  return ChatBubble(
                    message: currentMessage,
                    showAvatar: isGroupStart,
                    isGroup: currentMessage.isGroup(),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular((isGroupStart ? 8 : 8)),
                      topRight: Radius.circular(
                        !currentMessage.isMe()
                            ? (isGroupStart ? 8 : 8)
                            : (isGroupStart ? 8 : 4),
                      ),
                      bottomLeft: Radius.circular(
                        !currentMessage.isMe()
                            ? (isGroupEnd ? 8 : 4)
                            : (isGroupEnd ? 4 : 8),
                      ),
                      bottomRight: Radius.circular(
                        !currentMessage.isMe()
                            ? (isGroupEnd ? 4 : 8)
                            : (isGroupEnd ? 8 : 4),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
