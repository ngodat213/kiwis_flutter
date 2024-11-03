import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/views/change_language/change_language_controller.dart';
import 'package:kiwis_flutter/widgets/custom_icon_button.dart';
import '../../core/app_export.dart';
import 'models/changelanguagelistItem_model.dart';
import 'widgets/changelanguagelist_item_widget.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';

class ChangeLanguageScreen extends BaseView<ChangeLanguageController> {
  ChangeLanguageScreen({super.key});

  @override
  Widget body(BuildContext context) {
    return Align(
      child: Container(
        height: Get.height,
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 32.h),
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              child: _buildAppBar(),
            ),
            SizedBox(height: 32.h),
            _buildButtonLarge(),
            SizedBox(height: 16.h),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusStyle.roundedBorder24,
              ),
              child: Column(
                children: [
                  _allRegion(),
                  Obx(
                    () => _buildChangeLanguageList(),
                  ),
                  SizedBox(height: 4.h),
                  // _buildMicronesiaRow(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 44.h,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeftOnprimary,
        onTap: () {
          onTapArrowleftone();
        },
      ),
      title: AppbarTitle(
        text: "lbl_language".tr,
        margin: EdgeInsets.only(left: 16.h),
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

  Widget _allRegion() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadiusStyle.customBorderTop28,
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
              imagePath: ImageConstant.svgInbox,
            ),
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "All Region".tr,
                  style: theme.textTheme.titleSmall,
                ),
                Text(
                  "Your Location".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          SizedBox(width: 16.h),
          CustomImageView(
            imagePath: ImageConstant.svgScrollVertical,
            height: 16.h,
            width: 16.h,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildChangeLanguageList() {
    final data = controller
        .changeLanguageModelObj.value.changelanguagelistItemList.value;
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        ChangelanguagelistItemModel model = data[index];
        return Container(
          margin: EdgeInsets.only(top: 4.h),
          child: ChangelanguagelistItemWidget(
            model,
            isSelected: true,
            isMaxLenght: data.length == index + 1,
          ),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildMicronesiaRow() {
    return Container(
      padding: EdgeInsets.all(24.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.05),
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 22.h,
            width: 34.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary.withOpacity(1),
              borderRadius: BorderRadiusStyle.roundedBorder6,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.svgCircle,
                  height: 22.h,
                  width: double.maxFinite,
                  radius: BorderRadius.circular(
                    4.h,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.h),
            child: Text(
              "lbl_micronesia".tr,
              style: theme.textTheme.titleSmall,
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.svgCircle,
            height: 24.h,
            width: 26.h,
          )
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
