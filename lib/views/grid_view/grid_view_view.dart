import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import 'controller/grid_view_controller.dart';
import 'gridviewfreeini_tab_page.dart'; // ignore_for_file: must_be_immutable

class GridViewScreen extends GetWidget<GridViewController> {
  const GridViewScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildHorizontalScroll()],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildHorizontalScroll() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicWidth(
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
                  imagePath: ImageConstant.imgEllipse2005Primary280x544,
                  height: 280.h,
                  width: 546.h,
                  alignment: Alignment.topRight,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 360.h,
                    margin: EdgeInsets.only(
                      left: 16.h,
                      top: 32.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.customBorderTL24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CustomAppBar(
                          leadingWidth: 52.h,
                          leading: AppbarLeadingIconbutton(
                            imagePath: ImageConstant.imgArrowLeftOnprimary,
                            margin: EdgeInsets.only(left: 8.h),
                            onTap: () {
                              onTapArrowleftone();
                            },
                          ),
                          title: AppbarTitle(
                            text: "lbl_tours".tr,
                            margin: EdgeInsets.only(left: 16.h),
                          ),
                          actions: [
                            AppbarTrailingImage(
                              imagePath: ImageConstant.imgMenu,
                              margin: EdgeInsets.only(right: 8.h),
                            )
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(left: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomIconButton(
                                height: 40.h,
                                width: 40.h,
                                padding: EdgeInsets.all(8.h),
                                decoration:
                                    IconButtonStyleHelper.fillOnPrimaryTL20,
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgHistory,
                                ),
                              ),
                              SizedBox(width: 16.h),
                              Obx(
                                () => SizedBox(
                                  width: 286.h,
                                  child: TabBar(
                                    controller: controller.tabviewController,
                                    labelPadding: EdgeInsets.zero,
                                    labelColor: theme.colorScheme.onPrimary
                                        .withOpacity(1),
                                    labelStyle: TextStyle(
                                      fontSize: 12.fSize,
                                      fontFamily: 'Google Sans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                    unselectedLabelColor: theme
                                        .colorScheme.onPrimary
                                        .withOpacity(1),
                                    unselectedLabelStyle: TextStyle(
                                      fontSize: 12.fSize,
                                      fontFamily: 'Google Sans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                    tabs: [
                                      Tab(
                                        height: 36,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.maxFinite,
                                          margin: EdgeInsets.only(right: 6.h),
                                          decoration:
                                              controller.tabIndex.value == 0
                                                  ? BoxDecoration(
                                                      color: theme
                                                          .colorScheme.onPrimary
                                                          .withOpacity(0.05),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        18.h,
                                                      ))
                                                  : BoxDecoration(
                                                      color: theme
                                                          .colorScheme.onPrimary
                                                          .withOpacity(0.05),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        18.h,
                                                      ),
                                                    ),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 6.h),
                                          decoration:
                                              controller.tabIndex.value == 1
                                                  ? BoxDecoration(
                                                      color: theme
                                                          .colorScheme.onPrimary
                                                          .withOpacity(0.05),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        18.h,
                                                      ))
                                                  : BoxDecoration(
                                                      color: theme
                                                          .colorScheme.onPrimary
                                                          .withOpacity(0.05),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        18.h,
                                                      ),
                                                    ),
                                          child: Text(
                                            "lbl_newyork".tr,
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        height: 36,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.maxFinite,
                                          margin: EdgeInsets.only(left: 6.h),
                                          decoration:
                                              controller.tabIndex.value == 2
                                                  ? BoxDecoration(
                                                      color: theme
                                                          .colorScheme.onPrimary
                                                          .withOpacity(0.05),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        18.h,
                                                      ))
                                                  : BoxDecoration(
                                                      color: theme
                                                          .colorScheme.onPrimary
                                                          .withOpacity(0.05),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        18.h,
                                                      ),
                                                    ),
                                          child: Text(
                                            "lbl_free".tr,
                                          ),
                                        ),
                                      )
                                    ],
                                    indicatorColor: Colors.transparent,
                                    onTap: (index) {
                                      controller.tabIndex.value = index;
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.h,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.onPrimary,
                                  borderRadius:
                                      BorderRadiusStyle.circleBorder18,
                                ),
                                child: Text(
                                  "lbl_skip".tr,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.labelLarge,
                                ),
                              ),
                              SizedBox(width: 16.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.h,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.onPrimary,
                                  borderRadius:
                                      BorderRadiusStyle.circleBorder18,
                                ),
                                child: Text(
                                  "lbl_skip".tr,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.labelLarge,
                                ),
                              ),
                              SizedBox(width: 16.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.h,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.onPrimary,
                                  borderRadius:
                                      BorderRadiusStyle.circleBorder18,
                                ),
                                child: Text(
                                  "lbl_skip".tr,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.labelLarge,
                                ),
                              ),
                              SizedBox(width: 16.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.h,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.onPrimary,
                                  borderRadius:
                                      BorderRadiusStyle.circleBorder18,
                                ),
                                child: Text(
                                  "lbl_skip".tr,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.labelLarge,
                                ),
                              ),
                              SizedBox(width: 16.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.h,
                                          width: double.maxFinite,
                                        child: Container(
                                          alignment: Alignment.center,
                                        height: 36,
                                      Tab(
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.onPrimary,
                                  borderRadius:
                                      BorderRadiusStyle.circleBorder18,
                                ),
                                child: Text(
                                  "lbl_skip".tr,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.labelLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: TabBarView(
                              controller: controller.tabviewController,
                              children: [
                                Container(),
                                Container(),
                                GridviewfreeiniTabPage()
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
          ),
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildButtonsmallOne({required String priceOne}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 32.h,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadiusStyle.circleBorder18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgResize,
            height: 16.h,
            width: 16.h,
          ),
          SizedBox(width: 12.h),
          Text(
            priceOne,
            style: CustomTextStyles.labelLargeGray5002.copyWith(
              color: appTheme.gray5002,
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildRow({required String reviewscounter}) {
    return Row(
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgStar,
          height: 16.h,
          width: 16.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 4.h),
          child: Text(
            reviewscounter,
            style: CustomTextStyles.bodySmallOnPrimary.copyWith(
              color: theme.colorScheme.onPrimary.withOpacity(1),
            ),
          ),
        )
      ],
    );
  }

  /// Common widget
  Widget _buildRowlocation({required String canadaOne}) {
    return Row(
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgLocationOnprimary,
          height: 24.h,
          width: 24.h,
          radius: BorderRadius.circular(
            12.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.h),
          child: Text(
            canadaOne,
            style: CustomTextStyles.labelLargeGray5002.copyWith(
              color: appTheme.gray5002,
            ),
          ),
        )
      ],
    );
  }

  /// Common widget
  Widget _buildVietnamColumn({
    required String vietNamOne,
    required String reviewscounter,
    required String loremipsumissim,
    required String distance,
  }) {
    return Container(
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadiusStyle.circleBorder18,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 8.h),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgLocationOnprimary,
                  height: 24.h,
                  width: 24.h,
                  radius: BorderRadius.circular(
                    12.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: Text(
                    vietNamOne,
                    style: CustomTextStyles.labelLargeGray5002.copyWith(
                      color: appTheme.gray5002,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 28.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            child: Row(children: [
              CustomImageView(
                  imagePath: ImageConstant.imgStar,
                  height: 16.h,
                  width: 16.h,
                  alignment: Alignment.bottomCenter,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(
                    reviewscounter,
                    style: CustomTextStyles.bodySmallOnPrimary.copyWith(
                      color: theme.colorScheme.onPrimary.withOpacity(1),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            loremipsumissim,
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.onPrimary.withOpacity(0.5),
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 40.h,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
              borderRadius: BorderRadiusStyle.circleBorder18,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgResize,
                  height: 16.h,
                  width: 16.h,
                ),
                SizedBox(width: 12.h),
                Text(
                  distance,
                  style: CustomTextStyles.labelLargeGray5002.copyWith(
                    color: appTheme.gray5002,
                  ),
                )
              ],
            ),
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
