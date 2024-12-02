import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/models/group.model.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';

import 'message_controller.dart';

class MessageScreen extends BaseView<MessageController> {
  MessageScreen({super.key});

  @override
  bool get isNavigationBar => true;

  @override
  Widget body(BuildContext context) {
    return Container(
      height: Get.height,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: _buildHeaderSection(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: controller.groupList
                      .map((e) => _buildGroupItem(e))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildButtonLarge() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadiusStyle.circleBorder28,
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: Text(
              "lbl_typing".tr,
              style: theme.textTheme.titleMedium,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgClosePrimary,
            height: 24.h,
            width: 26.h,
            radius: BorderRadius.circular(
              12.h,
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildGroupItem(GroupModel group) {
    return GestureDetector(
      onTap: () => controller.onPressedChanel(group.groupId!),
      child: SizedBox(
        width: double.maxFinite,
        child: Container(
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
                        imagePath: group.groupAvatarUrl(),
                        fit: BoxFit.cover,
                        height: 47.h,
                        width: 47.h,
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
                      group.groupName(),
                      style: theme.textTheme.titleSmall!.copyWith(
                          color: theme.colorScheme.onPrimary.withOpacity(1)),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      group.lastMessage(),
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.onPrimary.withOpacity(0.5)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildHeaderSection() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 16), // Adjust padding as needed
      child: CustomAppBar(
        title: AppbarTitle(
          text: "Message".tr,
          margin: EdgeInsets.only(left: 16.h),
        ),
        actions: [
          AppbarTrailingIconbutton(
            // onTap: () => controller.showModalCalenderSheet(context),
            imagePath: ImageConstant.svgCalander,
            margin: EdgeInsets.only(right: 8.h),
          ),
          AppbarTrailingIconbutton(
            // onTap: () => controller.showModalSettingChatRoomSheet(context),
            imagePath: ImageConstant.svgMore,
            margin: EdgeInsets.only(right: 8.h),
          ),
        ],
      ),
    );
  }
}
