import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/app_export.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';

import 'message_controller.dart';

class MessageView extends BaseView<MessageController> {
  MessageView({super.key});

  @override
  bool get isNavigationBar => true;

  @override
  Widget body(BuildContext context) {
    return Container(
      height: Get.height,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: Get.height * 0.16),
            padding: EdgeInsets.symmetric(horizontal: 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // _buildButtonLarge(),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.maxFinite,
                  child: _buildAboutSectionRow(
                    inboxOne: ImageConstant.imgAvatar,
                    aboutOne: "Hydra Coder".tr,
                    applicationvers: "Qua chưa đang ở dâu".tr,
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: _buildAboutSectionRow(
                    inboxOne: ImageConstant.svgPrivacy,
                    aboutOne: "msg_privacy_and_term".tr,
                    applicationvers: "msg_change_password".tr,
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: _buildAboutSectionRow(
                    inboxOne: ImageConstant.svgPrivacy,
                    aboutOne: "msg_privacy_and_term".tr,
                    applicationvers: "msg_change_password".tr,
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: _buildAboutSectionRow(
                    inboxOne: ImageConstant.svgPrivacy,
                    aboutOne: "msg_privacy_and_term".tr,
                    applicationvers: "msg_change_password".tr,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: _buildHeaderSection(),
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
  Widget _buildHeaderSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.h, vertical: 32.h),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: EdgeInsets.zero,
        color: theme.colorScheme.onPrimary.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.roundedBorder24,
        ),
        child: Container(
          padding: EdgeInsets.all(24.h),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary.withOpacity(0.05),
            borderRadius: BorderRadiusStyle.roundedBorder24,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.svgMenuDefault,
                          height: 24.h,
                          width: 24.h,
                        ),
                        SizedBox(width: 24.h),
                        CustomImageView(
                          imagePath: ImageConstant.imgAvatar,
                          height: 40.h,
                          width: 40.h,
                          radius: BorderRadius.circular(
                            30.h,
                          ),
                        ),
                        SizedBox(width: 16.h),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "lbl_hello".tr,
                                style: theme.textTheme.labelLarge,
                              ),
                              Text(
                                "lbl_samms".tr,
                                style: theme.textTheme.titleLarge,
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          // onTap: notificationOnPressed,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0x0DFFFFFF),
                                borderRadius: BorderRadius.circular(100)),
                            padding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 16.h,
                            ),
                            child: Row(
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.svgSearch,
                                  height: 20.h,
                                  width: 20.h,
                                ),
                                SizedBox(width: 16.h),
                                CustomImageView(
                                  imagePath: ImageConstant.svgCalander,
                                  height: 20.h,
                                  width: 20.h,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
