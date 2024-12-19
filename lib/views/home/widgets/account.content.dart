import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/views/home/home_controller.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';
import 'package:velocity_x/velocity_x.dart';
import 'selection_row.widget.dart';

class AccountContent extends BaseView<HomeController> {
  AccountContent({super.key});

  /// Section Widget
  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Get.height * 0.13),
      child: Container(
        padding: EdgeInsets.only(top: 23),
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Obx(
          () => CustomAppBar(
            leadingWidth: 44.h,
            leading: AppbarLeadingIconbutton(
              imagePath: ImageConstant.imgArrowLeftOnprimary,
              onTap: () {
                Get.back();
              },
            ),
            title: AppbarTitle(
              text: "Account settings".tr,
              margin: EdgeInsets.only(left: 16.h),
            ),
            actions: [
              controller.isOnchangeAvatar.value
                  ? "Save"
                      .tr
                      .text
                      .textStyle(theme.textTheme.titleSmall)
                      .bold
                      .make()
                      .onTap(() {
                      controller.handleChangeAvatar(context);
                    })
                  : SizedBox.shrink(),
            ],
          ),
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
      child: Column(
        children: [
          SizedBox(height: 32.h),
          Obx(
            () => controller.isOnchangeAvatar.value
                ? CustomImageView(
                    imageBytes: controller.avatar.value.readAsBytesSync(),
                    imageType: ImageType.memory,
                    onTap: () => controller.pickAvatar(),
                    height: 100.h,
                    width: 100.h,
                    fit: BoxFit.cover,
                    radius: BorderRadius.circular(100.h),
                  )
                : CustomImageView(
                    onTap: () => controller.pickAvatar(),
                    imagePath: controller.user.value.avatarUrl,
                    imageType: ImageType.file,
                    height: 100.h,
                    width: 100.h,
                    fit: BoxFit.cover,
                    radius: BorderRadius.circular(100.h),
                  ),
          ),
          SizedBox(height: 16.h),
          Obx(
            () => controller.user.value.displayName.text
                .textStyle(CustomTextStyles.titleMediumGray5002)
                .make(),
          ),
          SizedBox(height: 64.h),
          SizedBox(
            width: double.maxFinite,
            child: SelectionRowWidget(
              inboxOne: ImageConstant.svgUser,
              aboutOne: "Change display name".tr,
              applicationvers: "Name will be displayed to other users".tr,
              onTap: () {
                controller.onPressedChangeNameContent(context);
              },
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: SelectionRowWidget(
              inboxOne: ImageConstant.svgPrivacy,
              aboutOne: "Change password".tr,
              applicationvers: "Change your password to secure your account".tr,
              onTap: () {
                controller.onPressedPasswordContent(context);
              },
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: SelectionRowWidget(
              inboxOne: ImageConstant.svgDeline,
              aboutOne: "Delete account".tr,
              applicationvers: "Permanently delete your account".tr,
              onTap: () {
                controller.onPressedDeleteAccountContent(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
