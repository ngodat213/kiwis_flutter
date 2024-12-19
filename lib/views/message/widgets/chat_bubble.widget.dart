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
      child: Column(
        children: [
          Visibility(
            visible: message.isComment(),
            child: Container(
              width: Get.width - 72.h,
              height: Get.width - 72.h,
              child: Stack(
                children: [
                  CustomImageView(
                    radius: BorderRadius.circular(12.h),
                    imagePath: message.post?.images?.first.imageUrl ?? "",
                    height: Get.width - 72.h,
                    width: Get.width - 72.h,
                    fit: BoxFit.cover,
                  ).paddingOnly(bottom: 10.h),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(15.h),
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.h,
                        vertical: 20.h,
                      ),
                      decoration: BoxDecoration(
                        color: appTheme.gray200.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.h),
                      ),
                      child: Text(
                        message.post?.caption ?? "",
                        style: theme.textTheme.bodySmall?.copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!message.isMe() && showAvatar)
                CustomImageView(
                  width: 40.h,
                  height: 40.h,
                  fit: BoxFit.cover,
                  radius: BorderRadius.circular(100),
                  imagePath: message.sender?.avatar?.imageUrl ??
                      AppValues.defaultAvatar,
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
                      child: message.sender!.fullName.text.bold
                          .textStyle(theme.textTheme.bodySmall)
                          .make()
                          .pOnly(right: 16.h, bottom: 4.h, left: 8.h),
                    ),
                    (message.text ?? "")
                        .tr
                        .text
                        .textStyle(theme.textTheme.bodySmall)
                        .make()
                        .pOnly(top: 10.h, bottom: 10.h, left: 16.h, right: 16.h)
                        .box
                        .customRounded(borderRadius)
                        .color(message.isMe()
                            ? appTheme.gray200.withOpacity(0.3)
                            : appTheme.gray200.withOpacity(0.5))
                        .make()
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
