import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/next_point/next_point_controller.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';

class NextPointScreen extends GetWidget<NextPointController> {
  const NextPointScreen({Key? key})
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
              height: 798.h,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 534.h,
                      decoration: BoxDecoration(
                        color: appTheme.blue200,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgGuidelineIllusPrimary,
                            height: 488.h,
                            width: double.maxFinite,
                            alignment: Alignment.topCenter,
                          ),
                          Container(
                            height: 534.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(0.5, 0),
                                end: Alignment(0.5, 1),
                                colors: [
                                  appTheme.gray900.withOpacity(0),
                                  appTheme.gray900
                                ],
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      24.h, 32.h, 24.h, 42.h),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: double.maxFinite,
                                        child: _buildAppBar(),
                                      ),
                                      Spacer(),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "lbl_exploer_in".tr,
                                              style: theme.textTheme.titleLarge,
                                            ),
                                            TextSpan(
                                              text: "lbl_london".tr,
                                              style:
                                                  theme.textTheme.displayMedium,
                                            )
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 10.h),
                                      Text(
                                        "msg_lorem_ipsum_is_simply6".tr,
                                        style: CustomTextStyles
                                            .titleSmallGoogleSansMediumOnPrimary,
                                      )
                                    ],
                                  ),
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.imgEllipse2005,
                                  height: 280.h,
                                  width: 274.h,
                                  alignment: Alignment.topRight,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  _buildMainContent()
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
        text: "lbl_tours".tr,
        margin: EdgeInsets.only(left: 16.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildMainContent() {
    return Container(
      height: 274.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 20.h,
                  width: 278.h,
                  margin: EdgeInsets.symmetric(horizontal: 32.h),
                  decoration: BoxDecoration(
                    color: appTheme.blueA40019.withOpacity(0.35),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.h),
                      topRight: Radius.circular(10.h),
                      bottomLeft: Radius.circular(2.h),
                      bottomRight: Radius.circular(2.h),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadiusStyle.roundedBorder32,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIconButton(
                              height: 48.h,
                              width: 48.h,
                              padding: EdgeInsets.all(12.h),
                              decoration: IconButtonStyleHelper.fillGray,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgLocationPrimary,
                              ),
                            ),
                            SizedBox(width: 16.h),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "lbl_search_in".tr,
                                    style: CustomTextStyles.labelLargeGray5002,
                                  ),
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        Text(
                                          "lbl_london".tr,
                                          style: CustomTextStyles
                                              .titleMediumGray5002,
                                        ),
                                        CustomImageView(
                                          imagePath: ImageConstant.imgDown,
                                          height: 16.h,
                                          width: 16.h,
                                          margin: EdgeInsets.only(left: 4.h),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 16.h),
                            CustomIconButton(
                              height: 40.h,
                              width: 40.h,
                              padding: EdgeInsets.all(8.h),
                              decoration:
                                  IconButtonStyleHelper.fillOnPrimaryTL20,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgClock,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Obx(
                          () => SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Wrap(
                              direction: Axis.horizontal,
                              runSpacing: 12.h,
                              spacing: 12.h,
                              children: List<Widget>.generate(
                                controller.nextPointModelObj.value
                                    .chipview4ItemList.value.length,
                                (index) {
                                  Chipview4ItemModel model = controller
                                      .nextPointModelObj
                                      .value
                                      .chipview4ItemList
                                      .value[index];
                                  return Chipview4ItemWidget(
                                    model,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 56.h),
                CustomImageView(
                  imagePath: ImageConstant.imgUp,
                  height: 24.h,
                  width: 26.h,
                )
              ],
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgEllipse2006Green600,
            height: 274.h,
            width: 344.h,
            alignment: Alignment.centerLeft,
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
