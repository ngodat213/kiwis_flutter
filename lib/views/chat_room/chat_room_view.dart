import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/views/chat_room/widgets/chat_bubble.widget.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';

import 'chat_room_controller.dart';

class ChatRoomView extends BaseView<ChatRoomController> {
  ChatRoomView({super.key});

  Widget? floatingActionButton(BuildContext context) {
    return Container(
      height: Get.height * 0.06,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32.h,
            height: 32.h,
            child: Icon(
              IconlyBold.location,
              color: appTheme.blue300,
            ),
          ),
          Container(
            width: 32.h,
            height: 32.h,
            child: Icon(
              IconlyBold.camera,
              color: appTheme.blue300,
            ),
          ),
          SizedBox(width: 8.h),
          CustomTextFormField(
            controller: controller.messageTEC,
            height: Get.height * 0.06,
            width: Get.width * 0.7,
            hintText: "Message",
            suffix: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () => controller.sendMessage(),
                  child: Icon(
                    IconlyBold.send,
                    color: appTheme.blue300,
                  ),
                ),
              ],
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 23.h, vertical: 12.h),
            borderDecoration: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.h),
              borderSide: BorderSide(width: 0),
            ),
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.h),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Get.height * 0.1),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: CustomAppBar(
          leadingWidth: 44.h,
          leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgArrowLeftOnprimary,
            onTap: () {
              Get.back();
            },
          ),
          title: AppbarTitle(
            text: controller.getGroupName(),
            margin: EdgeInsets.only(left: 16.h),
          ),
          actions: [
            AppbarTrailingIconbutton(
              onTap: () => controller.showModalCalenderSheet(context),
              imagePath: ImageConstant.svgCalander,
              margin: EdgeInsets.only(right: 8.h),
            ),
            AppbarTrailingIconbutton(
              onTap: () => controller.showModalSettingChatRoomSheet(context),
              imagePath: ImageConstant.svgMore,
              margin: EdgeInsets.only(right: 8.h),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      height: Get.height,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: Get.height * 0.78,
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
          ),
        ],
      ),
    );
  }
}
