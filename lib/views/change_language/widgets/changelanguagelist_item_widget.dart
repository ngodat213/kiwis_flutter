import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../models/changelanguagelistItem_model.dart';
import '../change_language_controller.dart';
import '../../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class ChangelanguagelistItemWidget extends StatelessWidget {
  ChangelanguagelistItemWidget(this.changelanguagelistItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ChangelanguagelistItemModel changelanguagelistItemModelObj;

  var controller = Get.find<ChangeLanguageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadiusStyle.roundedBorder6,
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
              imagePath: ImageConstant.imgInbox,
            ),
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    changelanguagelistItemModelObj.allRegion!.value,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Obx(
                  () => Text(
                    changelanguagelistItemModelObj.yourLocation!.value,
                    style: theme.textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 16.h),
          CustomImageView(
            imagePath: ImageConstant.imgScrollVertical,
            height: 16.h,
            width: 16.h,
          )
        ],
      ),
    );
  }
}
