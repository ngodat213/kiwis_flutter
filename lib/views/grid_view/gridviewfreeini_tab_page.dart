import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/grid_view_controller.dart';
import 'models/gridviewfreeini_tab_model.dart';

// ignore_for_file: must_be_immutable
class GridviewfreeiniTabPage extends StatelessWidget {
  GridviewfreeiniTabPage({Key? key})
      : super(
          key: key,
        );

  GridViewController controller = Get.put(GridViewController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 26.h,
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: _buildLondonRow(),
            ),
          )
        ],
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
          )
          SizedBox(height: 28.h),Container(width: double.infinity,
          
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            child: Row(
              children: [
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

  /// Section Widget
  Widget _buildLondonRow() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(right: 6.h),
                padding: EdgeInsets.all(8.h),
                decoration: BoxDecoration(
                  color: appTheme.green600,
                  borderRadius: BorderRadiusStyle.circleBorder18,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 8.h),
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 8.h),
                      child: _buildRowlocation(
                        canadaOne: "lbl_london".tr,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.h,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onPrimary.withOpacity(0.2),
                        borderRadius: BorderRadiusStyle.circleBorder18,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 2.h),
                          SizedBox(
                            width: double.maxFinite,
                            child: _buildRow(
                              reviewscounter: "lbl_25_reviews".tr,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            "msg_lorem_ipsum_is_simply".tr,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall!.copyWith(
                              height: 1.67,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _buildButtonsmallOne(
                      priceOne: "lbl_20_000".tr,
                    )
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(right: 6.h),
                child: _buildVietnamColumn(
                  vietNamOne: "lbl_canada".tr,
                  reviewscounter: "lbl_25_reviews".tr,
                  loremipsumissim: "msg_lorem_ipsum_is_simply".tr,
                  distance: "lbl_20_000".tr,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(right: 6.h),
                child: _buildVietnamColumn(
                  vietNamOne: "lbl_viet_nam".tr,
                  reviewscounter: "lbl_25_reviews".tr,
                  loremipsumissim: "msg_lorem_ipsum_is_simply2".tr,
                  distance: "lbl_20_km2".tr,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: 4.h),
                child: _buildVietnamColumn(
                  vietNamOne: "lbl_new_york2".tr,
                  reviewscounter: "lbl_25_reviews".tr,
                  loremipsumissim: "msg_lorem_ipsum_is_simply2".tr,
                  distance: "lbl_20_000".tr,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: 4.h),
                child: _buildVietnamColumn(
                  vietNamOne: "lbl_indonesia".tr,
                  reviewscounter: "lbl_25_reviews".tr,
                  loremipsumissim: "msg_lorem_ipsum_is_simply3".tr,
                  distance: "lbl_20_000".tr,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: 4.h),
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
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            child: _buildRowlocation(
                              canadaOne: "lbl_thailand".tr,
                            ),
                          ),
                          SizedBox(height: 32.h),
                          Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(horizontal: 8.h),
                            child: _buildRow(
                              reviewscounter: "lbl_25_reviews".tr,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          SizedBox(
                            width: 120.h,
                            child: Text(
                              "msg_lorem_ipsum_is_simply".tr,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall!.copyWith(
                                height: 1.67,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 44.h),
                    _buildButtonsmallOne(
                      priceOne: "lbl_20_km2".tr,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
