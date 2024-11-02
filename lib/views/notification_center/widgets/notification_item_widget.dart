import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/notification_center/models/notification_list_item.model.dart';
import 'package:kiwis_flutter/views/notification_center/notification_center_controller.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_icon_button.dart';

// ignore_for_file: must_be_immutable
class NotificationlistItemWidget extends StatelessWidget {
  NotificationlistItemWidget(this.notificationlistItemModelObj, {Key? key})
      : super(
          key: key,
        );

  NotificationListItemModel notificationlistItemModelObj;

  var controller = Get.find<NotificationCenterController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(14.h),
      decoration: BoxDecoration(
        color: appTheme.green600,
        borderRadius: BorderRadiusStyle.roundedBorder32,
        border: Border.all(
          color: appTheme.green600,
          width: 2.h,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                CustomIconButton(
                  height: 48.h,
                  width: 48.h,
                  padding: EdgeInsets.all(12.h),
                  decoration: IconButtonStyleHelper.fillOnPrimaryTL241,
                  child: CustomImageView(
                    imagePath: ImageConstant.svgBell,
                  ),
                ),
                SizedBox(width: 16.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          notificationlistItemModelObj.title!.value,
                          style: CustomTextStyles.labelLargeGray5002,
                        ),
                      ),
                      Obx(
                        () => Text(
                          notificationlistItemModelObj.london!.value,
                          style: CustomTextStyles.titleMediumGray5002,
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
                  decoration: IconButtonStyleHelper.none,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgClose,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            width: 268.h,
            margin: EdgeInsets.only(left: 10.h),
            child: Obx(
              () => Text(
                notificationlistItemModelObj.text!.value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    CustomTextStyles.titleSmallGoogleSansMediumMedium.copyWith(
                  height: 1.71,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    height: 36.h,
                    text: "lbl_dissmis".tr,
                    buttonStyle: CustomButtonStyles.fillOnPrimaryTl181,
                    buttonTextStyle: CustomTextStyles.labelLargeGreen600,
                  ),
                ),
                SizedBox(width: 12.h),
                Expanded(
                  child: CustomElevatedButton(
                    height: 36.h,
                    text: "lbl_comment".tr,
                    buttonStyle: CustomButtonStyles.fillOnPrimaryTl182,
                    buttonTextStyle: CustomTextStyles.labelLargeGray5002,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
