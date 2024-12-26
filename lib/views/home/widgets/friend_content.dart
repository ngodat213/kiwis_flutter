import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/home/home_controller.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:kiwis_flutter/widgets/custom_icon_button.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class FriendContent extends GetView<HomeController> {
  /// Section Widget
  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Get.height * 0.13),
      child: Container(
        padding: EdgeInsets.only(top: 23),
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
            text: "Friends".tr,
            margin: EdgeInsets.only(left: 16.h),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SizedBox(
        width: double.maxFinite,
        child: Container(
          child: Stack(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgEllipse2005,
                height: 280.h,
                width: 274.h,
                alignment: Alignment.topRight,
              ),
              CustomImageView(
                imagePath: ImageConstant.imgEllipse2006Green600516x342,
                height: 340.h,
                width: 240.h,
                alignment: Alignment.bottomLeft,
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    height: Get.height,
                    width: double.maxFinite,
                    margin: EdgeInsets.only(bottom: 48.h),
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    child: Obx(() {
                      return Column(
                        children: [
                          CustomSelection(
                            title: "Add Friend",
                            child: CustomTextFormField(
                              height: Get.height * 0.06,
                              hintText: "Phone number".tr,
                              controller: controller.phoneNumberTEC,
                              suffix: GestureDetector(
                                onTap: () =>
                                    controller.onPressedAddFriend(context),
                                child: Icon(
                                  Icons.send,
                                  color: appTheme.blue300,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 23.h, vertical: 12.h),
                            ),
                          ),
                          TabBar(
                            controller: controller.tabController,
                            indicatorColor: appTheme.green600,
                            labelColor: appTheme.green600,
                            dividerColor: Colors.transparent,
                            tabs: [
                              Tab(text: "Friends".tr),
                              Tab(text: "Pending".tr),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: controller.tabController,
                              children: [
                                Column(
                                  children: controller.user.value.friends!
                                      .map(
                                        (e) => SizedBox(
                                          width: double.maxFinite,
                                          child: _buildAboutSectionRow(
                                            userId: e.user!.userId!,
                                            avatar: e.user?.avatar?.imageUrl ??
                                                AppValues.defaultAvatar,
                                            fullName:
                                                "${e.user!.firstName} ${e.user!.lastName}"
                                                    .tr,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                Column(
                                  children: controller.friendsPending
                                      .map(
                                        (e) => SizedBox(
                                          width: double.maxFinite,
                                          child: _buildAboutSectionRow(
                                            userId: e.user!.userId!,
                                            avatar: e.user?.avatar?.imageUrl ??
                                                AppValues.defaultAvatar,
                                            fullName:
                                                "${e.user!.firstName} ${e.user!.lastName}"
                                                    .tr,
                                            isPending: true,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: CustomElevatedButton(
                              width: Get.width * 0.4,
                              text: "See All".tr,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildAboutSectionRow({
    required String avatar,
    required String fullName,
    bool isPending = false,
    required String userId,
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                    imagePath: avatar,
                    fit: BoxFit.cover,
                    height: 47.h,
                    width: 47.h,
                    radius: BorderRadiusStyle.roundedBorder24,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16.h),
          Text(
            fullName,
            style: theme.textTheme.titleSmall!
                .copyWith(color: theme.colorScheme.onPrimary.withOpacity(1)),
          ),
          Spacer(),
          CustomIconButton(
            onTap: () {},
            height: 44.h,
            width: 44.h,
            child: Icon(
              Icons.close,
              color: theme.colorScheme.onPrimary.withOpacity(0.5),
            ),
          ),
          SizedBox(width: 8.h),
          if (isPending)
            CustomIconButton(
              onTap: () => controller.acceptFriend(userId),
              height: 44.h,
              width: 44.h,
              decoration: BoxDecoration(
                color: appTheme.green600,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}

class CustomSelection extends StatelessWidget {
  const CustomSelection({
    super.key,
    required this.title,
    required this.child,
  });
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        title.tr.text.bold.textStyle(theme.textTheme.labelMedium).make(),
        SizedBox(height: 16.h),
        child,
      ],
    ).paddingOnly(bottom: 32.h);
  }
}
