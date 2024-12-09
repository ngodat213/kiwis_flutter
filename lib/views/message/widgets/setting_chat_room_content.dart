import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/message/message_controller.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton.dart';
import 'package:kiwis_flutter/widgets/base_appbar.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingChatRoomContent extends GetView<MessageController> {
  const SettingChatRoomContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: baseAppBar(context: context, title: "Setting".tr),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => CustomImageView(
                    width: 100.h,
                    height: 100.h,
                    fit: BoxFit.cover,
                    radius: BorderRadius.circular(100),
                    imagePath: controller.getAvatarGroup(),
                  ),
                ),
                SizedBox(height: 8.h),
                Obx(
                  () => controller
                      .getGroupName()
                      .text
                      .textStyle(theme.textTheme.titleLarge)
                      .bold
                      .make(),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => controller.onPressedCreatePlan(),
                      child: Container(
                        child: Column(
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
                      ),
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
                    onTap: () => controller.showModalGroupNameSheet(context),
                    inboxOne: ImageConstant.svgInbox,
                    aboutOne: controller.isGroupChat()
                        ? "Group Name".tr
                        : "Edit name".tr,
                    applicationvers: controller.isGroupChat()
                        ? "Change group name or avatar".tr
                        : "Change name and avatar".tr,
                  ),
                ),
                Visibility(
                  visible: controller.isGroupChat(),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: _buildAboutSectionRow(
                      onTap: () => controller.showModalMembersContent(context),
                      inboxOne: ImageConstant.svgGroup,
                      aboutOne: "Members".tr,
                      applicationvers: "msg_application_version".tr,
                    ),
                  ),
                ),
                controller.isGroupChat()
                    ? SizedBox(
                        width: double.maxFinite,
                        child: _buildAboutSectionRow(
                          onTap: () =>
                              controller.showModalGroupNameSheet(context),
                          inboxOne: ImageConstant.svgGroup,
                          aboutOne: "Add member".tr,
                          applicationvers: "msg_application_version".tr,
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  width: double.maxFinite,
                  child: _buildAboutSectionRow(
                    onTap: () => controller.showModalGroupNameSheet(context),
                    inboxOne: ImageConstant.svgStack,
                    aboutOne: "Gallery".tr,
                    applicationvers: "All images".tr,
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: _buildAboutSectionRow(
                    onTap: () => controller.showModalGroupNameSheet(context),
                    inboxOne: ImageConstant.svgInbox,
                    aboutOne:
                        controller.isGroupChat() ? "Out group".tr : "Block".tr,
                    applicationvers: controller.isGroupChat()
                        ? "Out group".tr
                        : "You will unfollow this user".tr,
                  ),
                ),
              ],
            ),
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
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.colorScheme.onPrimary.withOpacity(0.05),
              width: 1.h,
            ),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          title: Text(
            aboutOne,
            style: theme.textTheme.titleSmall!
                .copyWith(color: theme.colorScheme.onPrimary.withOpacity(1)),
          ),
          subtitle: Text(
            applicationvers,
            style: theme.textTheme.bodySmall!
                .copyWith(color: theme.colorScheme.onPrimary.withOpacity(0.5)),
          ),
          leading: Container(
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
      ),
    );
  }
}
