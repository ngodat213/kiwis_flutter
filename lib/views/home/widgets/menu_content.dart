import 'package:flutter/material.dart' hide MenuController;
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/core/constants/app.button_style.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/home/home_controller.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:kiwis_flutter/widgets/custom_icon_button.dart';
import 'selection_row.widget.dart';

class MenuContent extends BaseView<HomeController> {
  MenuContent({super.key});

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
            text: "Setting".tr,
            margin: EdgeInsets.only(left: 16.h),
          ),
          actions: [
            AppbarLeadingIconbutton(
              imagePath: ImageConstant.svgGroup,
              onTap: () {
                controller.onPressedFriend(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget? floatingActionButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () => controller.onPressedLogout(context),
      text: "lbl_logout".tr,
      buttonStyle: CustomButtonStyles.fillOnPrimaryTL28,
    ).marginSymmetric(horizontal: 32, vertical: 16);
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      height: Get.height,
      width: double.maxFinite,
      margin: EdgeInsets.only(bottom: 48.h),
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeaderSection(),
          // SizedBox(height: 16.h),
          // _buildSavedPlacesRow(),
          SizedBox(height: 16.h),
          // _buildPaymentSettingsRow(),
          // _buildLanguageSettingsRow(),
          SizedBox(
            width: double.maxFinite,
            child: SelectionRowWidget(
              inboxOne: ImageConstant.svgSetting,
              aboutOne: "Account settings".tr,
              applicationvers: "msg_change_password".tr,
              onTap: () {
                controller.onPressedAccount(context);
              },
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: SelectionRowWidget(
              inboxOne: ImageConstant.svgCalander,
              aboutOne: "My plan".tr,
              applicationvers: "msg_change_password".tr,
              onTap: () {
                controller.onPressedMyPlan();
              },
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: SelectionRowWidget(
              inboxOne: ImageConstant.svgPrivacy,
              aboutOne: "msg_privacy_and_term".tr,
              applicationvers: "msg_change_password".tr,
              onTap: () {},
            ),
          ),

          SizedBox(
            width: double.maxFinite,
            child: SelectionRowWidget(
              inboxOne: ImageConstant.svgInbox,
              aboutOne: "lbl_about".tr,
              applicationvers: "msg_application_version".tr,
              onTap: () {},
            ),
          ),
          SizedBox(height: 62.h),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildHeaderSection() {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: EdgeInsets.zero,
        color: theme.colorScheme.onPrimary.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.roundedBorder24,
        ),
        child: Container(
          height: 108.h,
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
                  Obx(() {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.h),
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          CustomImageView(
                            imagePath: controller.user.value.avatar?.imageUrl ??
                                AppValues.defaultAvatar,
                            height: 60.h,
                            width: 60.h,
                            fit: BoxFit.cover,
                            radius: BorderRadius.circular(
                              30.h,
                            ),
                          ),
                          SizedBox(width: 16.h),
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
                                  "${controller.user.value.firstName}".tr,
                                  style: theme.textTheme.titleLarge,
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 16.h),
                          CustomImageView(
                            imagePath: ImageConstant.svgBell,
                            height: 20.h,
                            width: 20.h,
                          )
                        ],
                      ),
                    );
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Navigates to the previous screen.
  void onTapArrowleftone() {
    Get.back();
  }
}
