import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/app_export.dart';
import 'package:velocity_x/velocity_x.dart';

class SendText extends StatelessWidget {
  const SendText({
    super.key,
    this.isFirst = false,
    this.isLast = false,
    this.isMe = false,
  });
  final bool isFirst;
  final bool isLast;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.h, top: isMe ? 8 : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMe || !isFirst
              ? !isFirst
                  ? SizedBox(width: !isMe ? 40 : 0)
                  : Container()
              : CustomImageView(
                  imagePath: ImageConstant.imgAvatar,
                ),
          SizedBox(width: isMe ? 0 : 8.h),
          "Nulla quis exercitation ullamco laboris qui aliquip officia non deserunt excepteur eu commodo do. Laboris esse excepteur elit laborum voluptate adipisicing officia consequat occaecat amet Lorem duis et amet. Labore elit ea culpa nisi proident dolore nostrud aliquip reprehenderit. Fugiat cillum aliqua officia et velit nulla voluptate tempor aliqua."
              .tr
              .text
              .white
              .textStyle(theme.textTheme.labelMedium)
              .make()
              .w(Get.width * 0.7)
              .p(10.h)
              .box
              .customRounded(BorderRadius.only(
                topLeft: Radius.circular(isMe || !isFirst
                    ? isLast || !isFirst
                        ? 8
                        : 16
                    : 4),
                topRight: Radius.circular(isMe || !isFirst
                    ? isLast
                        ? 8
                        : 4
                    : 16),
                bottomLeft: Radius.circular(isFirst
                    ? 8
                    : isLast
                        ? 16
                        : 8),
                bottomRight: Radius.circular(isFirst
                    ? 8
                    : isLast
                        ? 16
                        : 8),
              ))
              .color(theme.colorScheme.onPrimary)
              .make(),
          SizedBox(width: isMe ? 8.h : 0),
          isMe
              ? CustomImageView(
                  imagePath: ImageConstant.imgAvatar,
                )
              : Container()
        ],
      ),
    );
  }
}
