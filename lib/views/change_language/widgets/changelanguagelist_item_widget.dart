import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../models/changelanguagelistItem_model.dart';
import '../change_language_controller.dart';

// ignore_for_file: must_be_immutable
class ChangelanguagelistItemWidget extends StatelessWidget {
  ChangelanguagelistItemWidget(this.changelanguagelistItemModelObj,
      {Key? key, this.isSelected, this.isMaxLenght})
      : super(
          key: key,
        );

  ChangelanguagelistItemModel changelanguagelistItemModelObj;
  final bool? isSelected;
  final bool? isMaxLenght;

  var controller = Get.find<ChangeLanguageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.05),
        borderRadius: isMaxLenght == true
            ? BorderRadiusStyle.customBorderBottom28
            : BorderRadiusStyle.roundedBorder6,
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
                  imagePath: ImageConstant.svgVietNam,
                  width: 34.h,
                  fit: BoxFit.fill,
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
              changelanguagelistItemModelObj.allRegion!.value,
              style: theme.textTheme.titleSmall,
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: isSelected == true
                ? ImageConstant.svgCheck
                : ImageConstant.svgCircle,
            height: 24.h,
            width: 26.h,
          )
        ],
      ),
    );
  }
}
