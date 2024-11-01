import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/explore_location_main/explore_location_main_controller.dart';
import 'package:kiwis_flutter/views/explore_location_main/models/post_list_item.model.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_icon_button.dart';

// ignore_for_file: must_be_immutable
class PostlistItemWidget extends StatelessWidget {
  PostlistItemWidget(this.postlistItemModelObj, {Key? key})
      : super(
          key: key,
        );

  PostListItemModel postlistItemModelObj;

  var controller = Get.find<ExploreLocationMainController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220.h,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 220.h,
          padding: EdgeInsets.all(12.h),
          decoration: BoxDecoration(
            color: appTheme.blueA40019,
            borderRadius: BorderRadiusStyle.roundedBorder24,
            border: Border.all(
              color: theme.colorScheme.primary,
              width: 3.h,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onPrimary.withOpacity(1),
                        borderRadius: BorderRadiusStyle.circleBorder18,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Obx(
                            () => CustomImageView(
                              imagePath: postlistItemModelObj.postInOne!.value,
                              height: 40.h,
                              width: double.maxFinite,
                              radius: BorderRadius.circular(
                                20.h,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 16.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              postlistItemModelObj.postInTwo!.value,
                              style: CustomTextStyles
                                  .labelLargeGoogleSansMediumOnPrimary,
                            ),
                          ),
                          Obx(
                            () => Text(
                              postlistItemModelObj.greenwich!.value,
                              style: theme.textTheme.titleSmall,
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
                      decoration: IconButtonStyleHelper.fillOnPrimaryTL20,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgArrowRight,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 34.h),
              SizedBox(
                width: 170.h,
                child: Obx(
                  () => Text(
                    postlistItemModelObj.text!.value,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.labelLargeGoogleSansMedium.copyWith(
                      height: 1.67,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSaveButton(),
                  SizedBox(width: 12.h),
                  Obx(
                    () => CustomIconButton(
                      height: 40.h,
                      width: 66.h,
                      padding: EdgeInsets.all(12.h),
                      decoration: IconButtonStyleHelper.none,
                      child: CustomImageView(
                        imagePath: postlistItemModelObj.interfaceOne!.value,
                      ),
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
  Widget _buildSaveButton() {
    return CustomElevatedButton(
        height: 40.h,
        width: 108.h,
        text: "lbl_save".tr,
        leftIcon: Container(
          margin: EdgeInsets.only(right: 12.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgStarGreen300,
            height: 16.h,
            width: 16.h,
            fit: BoxFit.contain,
          ),
        ),
        buttonStyle: CustomButtonStyles.fillOnPrimaryTL183,
        buttonTextStyle: CustomTextStyles.titleSmallGreen300);
  }
}
