import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/change_language/change_language_controller.dart';
import '../../core/app_export.dart';

class ChangeLanguageScreen extends GetWidget<ChangeLanguageController> {
  const ChangeLanguageScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              height: 1040.h,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgEllipse2006Green600516x342,
                    height: 516.h,
                    width: 344.h,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgEllipse2005,
                    height: 280.h,
                    width: 274.h,
                    alignment: Alignment.topRight,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: 32.h),
                      padding: EdgeInsets.symmetric(horizontal: 24.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                                _buildChangeLanguageList(),
                                SizedBox(height: 4.h),
                                _buildMicronesiaRow(),
                                SizedBox(height: 4.h),
                                _buildLanguageRow()
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
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

  /// Section Widget
  Widget _buildChangeLanguageList() {
    return Obx(
      () => ListView.separated(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 4.h,
          );
        },
        itemCount: controller.changeLanguageModelObj.value
            .changelanguagelistItemList.value.length,
        itemBuilder: (context, index) {
          ChangelanguagelistItemModel model = controller.changeLanguageModelObj
              .value.changelanguagelistItemList.value[index];
          return ChangelanguagelistItemWidget(
            model,
          );
        },
      ),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 4.h,
          );
        },
        itemCount: controller.changeLanguageModelObj.value
            .changelanguagelistItemList.value.length,
        itemBuilder: (context, index) {
          ChangelanguagelistItemModel model = controller.changeLanguageModelObj
              .value.changelanguagelistItemList.value[index];
          return ChangelanguagelistItemWidget(
            model,
          );
        },
      ),
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
                  imagePath: ImageConstant.imgTelevisionBlue500,
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
            imagePath: ImageConstant.imgCircle,
            height: 24.h,
            width: 26.h,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLanguageRow() {
    return Container(
      padding: EdgeInsets.all(24.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.05),
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  imagePath: ImageConstant.imgTelevisionBlue500,
                  height: 22.h,
                  width: double.maxFinite,
                  radius: BorderRadius.circular(
                    4.h,
                  ),
                )
              ],
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgCircle,
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

