import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'package:kiwis_flutter/core/app_export.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';

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
            height: Get.height * 0.06,
            width: Get.width * 0.7,
            hintText: "Message",
            suffix: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  IconlyBold.send,
                  color: appTheme.blue300,
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
              color: AppColors.primaryColor,
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
            text: "DMT".tr,
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

class CalenderView extends StatelessWidget {
  const CalenderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Get.height * 0.09),
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
            text: "Calender".tr,
            margin: EdgeInsets.only(left: 16.h),
          ),
          actions: [
            AppbarTrailingIconbutton(
              imagePath: ImageConstant.svgCalander,
              margin: EdgeInsets.only(right: 8.h),
            ),
            AppbarTrailingIconbutton(
              imagePath: ImageConstant.svgMore,
              margin: EdgeInsets.only(right: 8.h),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingChatRoom extends StatelessWidget {
  const SettingChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.h),
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImageView(
                width: 100.h,
                height: 100.h,
                imagePath: ImageConstant.imgAvatar,
              ),
              SizedBox(height: 8.h),
              "DMT".tr.text.textStyle(theme.textTheme.titleLarge).bold.make(),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      AppbarTrailingIconbutton(
                        imagePath: ImageConstant.svgCalander,
                        margin: EdgeInsets.only(right: 8.h),
                      ),
                      "Create plan"
                          .tr
                          .text
                          .textStyle(theme.textTheme.labelMedium)
                          .make(),
                    ],
                  ),
                  SizedBox(width: 16.h),
                  Column(
                    children: [
                      AppbarTrailingIconbutton(
                        imagePath: ImageConstant.svgBell,
                        margin: EdgeInsets.only(right: 8.h),
                      ),
                      "Notification"
                          .tr
                          .text
                          .textStyle(theme.textTheme.labelMedium)
                          .make(),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Align(
                alignment: Alignment.topLeft,
                child: "Action"
                    .tr
                    .text
                    .textStyle(theme.textTheme.titleLarge)
                    .bold
                    .make(),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildAboutSectionRow(
                  inboxOne: ImageConstant.svgInbox,
                  aboutOne: "Group Name".tr,
                  applicationvers: "msg_application_version".tr,
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildAboutSectionRow(
                  inboxOne: ImageConstant.svgInbox,
                  aboutOne: "Add member".tr,
                  applicationvers: "msg_application_version".tr,
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildAboutSectionRow(
                  inboxOne: ImageConstant.svgInbox,
                  aboutOne: "Gallery".tr,
                  applicationvers: "msg_application_version".tr,
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildAboutSectionRow(
                  inboxOne: ImageConstant.svgInbox,
                  aboutOne: "Out group".tr,
                  applicationvers: "msg_application_version".tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildAboutSectionRow({
    required String inboxOne,
    required String aboutOne,
    required String applicationvers,
  }) {
    return Container(
      padding: EdgeInsets.only(
        top: 16.h,
        bottom: 14.h,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.onPrimary.withOpacity(0.05),
            width: 1.h,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 48.h,
              width: 48.h,
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimary,
                borderRadius: BorderRadiusStyle.roundedBorder24,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomImageView(
                    imagePath: inboxOne,
                    height: 24.h,
                    width: 26.h,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  aboutOne,
                  style: theme.textTheme.titleSmall!.copyWith(
                      color: theme.colorScheme.onPrimary.withOpacity(1)),
                ),
                SizedBox(height: 2.h),
                Text(
                  applicationvers,
                  style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.colorScheme.onPrimary.withOpacity(0.5)),
                )
              ],
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
            text: "DMT".tr,
            margin: EdgeInsets.only(left: 16.h),
          ),
        ),
      ),
    );
  }
}

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
