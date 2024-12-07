import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/models/message.model.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  final bool showAvatar;
  final bool isGroup;
  final BorderRadius borderRadius;

  const ChatBubble({
    super.key,
    required this.message,
    required this.showAvatar,
    this.isGroup = false,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 4.h,
        top: showAvatar ? 8 : 0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (!message.isMe() && showAvatar)
            CustomImageView(
              width: 40.h,
              height: 40.h,
              fit: BoxFit.cover,
              radius: BorderRadius.circular(100),
              imagePath:
                  message.sender?.avatar?.imageUrl ?? AppValues.defaultAvatar,
            )
          else if (!message.isMe())
            SizedBox(width: 40.h),
          SizedBox(width: message.isMe() ? 0 : 8.h),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: message.isMe()
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: isGroup && !message.isMe() && showAvatar,
                  child: message.sender!.fullName.text.white
                      .textStyle(theme.textTheme.labelMedium)
                      .make()
                      .pOnly(right: 16.h, bottom: 4.h, left: 8.h),
                ),
                message.text!.tr.text.white
                    .textStyle(theme.textTheme.labelMedium)
                    .make()
                    .pOnly(top: 10.h, bottom: 10.h, left: 16.h, right: 16.h)
                    .box
                    .customRounded(borderRadius)
                    .color(message.isMe()
                        ? appTheme.black900.withOpacity(0.3)
                        : appTheme.black900.withOpacity(0.5))
                    .make()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
