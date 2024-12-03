import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/views/chat_room/widgets/chat_room_content.dart';
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
      preferredSize: Size.fromHeight(Get.height * 0.09), // Set desired height
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 16), // Adjust padding as needed
        child: CustomAppBar(
          leadingWidth: 44.h,
          leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgArrowLeftOnprimary,
            onTap: () {
              Get.back();
            },
          ),
          title: AppbarTitle(
            text: controller.group.value.name?.tr ??
                controller.group.value.members!.first.user!.fullName,
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
    return ChatRoomContent();
  }
}
