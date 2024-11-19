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

class MenuContent extends BaseView<HomeController> {
  MenuContent({super.key});

  @override
  bool get isNavigationBar => true;
  @override
  Widget body(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(bottom: 48.h),
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeaderSection(),
          SizedBox(height: 16.h),
          _buildSavedPlacesRow(),
          SizedBox(height: 16.h),
          _buildPaymentSettingsRow(),
          _buildLanguageSettingsRow(),
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
              inboxOne: ImageConstant.svgInbox,
              aboutOne: "lbl_about".tr,
              applicationvers: "msg_application_version".tr,
            ),
          ),
          SizedBox(height: 62.h),
          CustomElevatedButton(
            onPressed: () => controller.onPressedLogout(),
            text: "lbl_logout".tr,
            buttonStyle: CustomButtonStyles.fillOnPrimaryTL28,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAppBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: CustomAppBar(
        leadingWidth: 68.h,
        leading: AppbarLeadingIconbutton(
          imagePath: ImageConstant.imgArrowLeftOnprimary,
          margin: EdgeInsets.only(left: 24.h),
          onTap: () {
            onTapArrowleftone();
          },
        ),
        title: AppbarTitle(
          text: "lbl_menu".tr,
          margin: EdgeInsets.only(left: 16.h),
        ),
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgAvatar,
                          height: 60.h,
                          width: 60.h,
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
                                "lbl_samms".tr,
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSavedPlacesRow() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.h),
              decoration: BoxDecoration(
                color: appTheme.green600,
                borderRadius: BorderRadiusStyle.roundedBorder24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(
                    height: 48.h,
                    width: 48.h,
                    padding: EdgeInsets.all(12.h),
                    decoration: IconButtonStyleHelper.fillOnPrimaryTL24,
                    child: CustomImageView(
                      imagePath: ImageConstant.svgStar,
                    ),
                  ),
                  SizedBox(width: 12.h),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "lbl_saved_place".tr,
                          style: theme.textTheme.bodySmall,
                        ),
                        Text(
                          "lbl_1000".tr,
                          style: theme.textTheme.titleLarge,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.h),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadiusStyle.roundedBorder24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(
                    height: 48.h,
                    width: 48.h,
                    padding: EdgeInsets.all(12.h),
                    decoration: IconButtonStyleHelper.fillOnPrimaryTL24,
                    child: CustomImageView(
                      imagePath: ImageConstant.svgDollar,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.only(right: 4.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "lbl_total_payout".tr,
                            style: theme.textTheme.bodySmall,
                          ),
                          Text(
                            "lbl_10002".tr,
                            style: theme.textTheme.titleLarge,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPaymentSettingsRow() {
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
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconButton(
            height: 48.h,
            width: 48.h,
            padding: EdgeInsets.all(12.h),
            decoration: IconButtonStyleHelper.fillOnPrimaryTL24,
            child: CustomImageView(
              imagePath: ImageConstant.imgStack,
            ),
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "msg_payment_settings".tr,
                  style: theme.textTheme.titleSmall,
                ),
                Text(
                  "lbl_02_card_added".tr,
                  style: theme.textTheme.bodySmall,
                )
              ],
            ),
          ),
          SizedBox(width: 16.h),
          CustomElevatedButton(
            height: 32.h,
            width: 68.h,
            text: "lbl_visa".tr,
            rightIcon: Container(
              margin: EdgeInsets.only(left: 4.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgRight,
                height: 16.h,
                width: 16.h,
                fit: BoxFit.contain,
              ),
            ),
            buttonTextStyle: CustomTextStyles.labelLargeOnPrimary,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLanguageSettingsRow() {
    return GestureDetector(
      onTap: () {
        controller.onPressedChangeLanguage();
      },
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
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconButton(
              height: 48.h,
              width: 48.h,
              padding: EdgeInsets.all(12.h),
              decoration: IconButtonStyleHelper.fillOnPrimaryTL24,
              child: CustomImageView(
                imagePath: ImageConstant.svgFlag,
              ),
            ),
            SizedBox(width: 16.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "lbl_change_language".tr,
                    style: theme.textTheme.titleSmall,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "msg_apperiance_currency".tr,
                    style: theme.textTheme.bodySmall,
                  )
                ],
              ),
            ),
            SizedBox(width: 16.h),
            CustomElevatedButton(
              onPressed: () {
                controller.onPressedChangeLanguage();
              },
              height: 32.h,
              width: 92.h,
              text: "lbl_vietnam2".tr,
              rightIcon: Container(
                margin: EdgeInsets.only(left: 4.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgRight,
                  height: 16.h,
                  width: 16.h,
                  fit: BoxFit.contain,
                ),
              ),
              buttonTextStyle: CustomTextStyles.labelLargeOnPrimary,
            )
          ],
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

  /// Navigates to the previous screen.
  void onTapArrowleftone() {
    Get.back();
  }
}
