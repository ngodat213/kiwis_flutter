import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/models/group.model.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';

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
            child: _buildHeaderSection(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32.h),
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.groups.length,
                    itemBuilder: (context, index) => _buildGroupItem(
                      context,
                      controller.groups[index],
                      index,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildGroupItem(BuildContext context, GroupModel group, int index) {
    return GestureDetector(
      onTap: () => controller.onPressedChanel(context, index),
      child: SizedBox(
        width: double.maxFinite,
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
            leading: CustomImageView(
              imagePath: group.groupAvatarUrl(),
              fit: BoxFit.cover,
              height: 47.h,
              width: 47.h,
              radius: BorderRadius.circular(100),
            ),
            title: Text(
              group.groupName(),
              style: theme.textTheme.titleSmall!
                  .copyWith(color: theme.colorScheme.onPrimary.withOpacity(1)),
            ),
            subtitle: Text(
              group.lastMessage(),
              style: theme.textTheme.bodySmall!.copyWith(
                  color: theme.colorScheme.onPrimary.withOpacity(0.5)),
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: CustomAppBar(
        title: AppbarTitle(
          text: "Message".tr,
          margin: EdgeInsets.only(left: 16.h),
        ),
        actions: [
          AppbarLeadingIconbutton(
            // onTap: () => controller.showModalCalenderSheet(context),
            imagePath: ImageConstant.svgCalander,
            margin: EdgeInsets.only(right: 8.h),
          ),
          AppbarLeadingIconbutton(
            onTap: () => controller.onPressedCreateGroup(context),
            imagePath: ImageConstant.svgMore,
            margin: EdgeInsets.only(right: 8.h),
          ),
        ],
      ),
    );
  }
}
