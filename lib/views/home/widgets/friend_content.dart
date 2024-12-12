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

class FriendContent extends BaseView<HomeController> {
  /// Section Widget
  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Get.height * 0.13), // Set desired height
      child: Container(
        padding: EdgeInsets.only(top: 23),
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
            text: "Friends".tr,
            margin: EdgeInsets.only(left: 16.h),
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
      margin: EdgeInsets.only(bottom: 48.h),
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        children: [
          CustomSelection(
            title: "Your link",
            child: CustomTextFormField(
              height: Get.height * 0.06,
              hintText: "https://kiwis.app/add/hydracoder".tr,
              suffix: Icon(
                Icons.link,
                color: appTheme.blue300,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 23.h, vertical: 12.h),
            ),
          ),
          CustomSelection(
            title: "Add Friend",
            child: CustomTextFormField(
              height: Get.height * 0.06,
              hintText: "uid".tr,
              controller: controller.friendIdTEC,
              suffix: GestureDetector(
                onTap: () => controller.onPressedAddFriend(context),
                child: Icon(
                  Icons.send,
                  color: appTheme.blue300,
                ),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 23.h, vertical: 12.h),
            ),
          ),
          CustomSelection(
            title: "Friends",
            child: Column(
              children: controller.user.value.friends!
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.CHAT_ROOM);
                      },
                      child: SizedBox(
                        width: double.maxFinite,
                        child: _buildAboutSectionRow(
                          avatar: e.user?.avatar?.imageUrl ??
                              AppValues.defaultAvatar,
                          fullName:
                              "${e.user!.firstName} ${e.user!.lastName}".tr,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Center(
            child: CustomElevatedButton(
              width: Get.width * 0.4,
              text: "See All".tr,
            ),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildAboutSectionRow({
    required String avatar,
    required String fullName,
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
