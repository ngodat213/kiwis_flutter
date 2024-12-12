import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/message/message_controller.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_trainling_iconbutton.dart';
import 'package:kiwis_flutter/widgets/base_appbar.dart';
import 'package:velocity_x/velocity_x.dart';

class MembersContent extends GetView<MessageController> {
  const MembersContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: baseAppBar(
          context: context,
          title: "Members".tr,
          actions: [
            "Add"
                .tr
                .text
                .textStyle(theme.textTheme.titleSmall)
                .bold
                .make()
                .onTap(() {
              controller.showModalMemberSettingSheet(context);
            }),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 32.h),
                ListView.builder(
                  itemCount: controller
                          .groups
                          .value[controller.currentGroupIndex.value]
                          .members
                          ?.length ??
                      0,
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final member = controller
                        .groups
                        .value[controller.currentGroupIndex.value]
                        .members![index];
                    return ListTile(
                      leading: CustomImageView(
                        imagePath: member.user?.avatar?.imageUrl ??
                            AppValues.defaultAvatar,
                        height: 47.h,
                        width: 47.h,
                        radius: BorderRadius.circular(100),
                        fit: BoxFit.cover,
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          member.user!.fullName.text
                              .textStyle(
                                theme.textTheme.titleSmall!.copyWith(
                                  color: theme.colorScheme.onPrimary
                                      .withOpacity(1),
                                ),
                              )
                              .make(),
                        ],
                      ),
                      trailing: Obx(
                        () => controller.selectedFriends.contains(member)
                            ? CustomImageView(
                                imagePath: ImageConstant.svgCheckCircle,
                                height: 24.h,
                                width: 24.h,
                              )
                            : CustomImageView(
                                imagePath: ImageConstant.svgCircle,
                                height: 24.h,
                                width: 24.h,
                              ),
                      ),
                    );
                  },
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
