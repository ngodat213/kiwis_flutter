import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/history_search/history_search_controller.dart';
import 'package:kiwis_flutter/views/history_search/models/history_section_item.model.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_icon_button.dart';

// ignore_for_file: must_be_immutable
class ListsectionItemWidget extends StatelessWidget {
  ListsectionItemWidget(this.listsectionItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ListSectionItemModel listsectionItemModelObj;

  var controller = Get.find<HistorySearchController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.2),
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgLocationOnprimary,
                  height: 24.h,
                  width: 26.h,
                  radius: BorderRadius.circular(
                    12.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Obx(
                    () => Text(
                      listsectionItemModelObj.thainlandTwo!.value,
                      style: CustomTextStyles.labelLargeGray5002,
                    ),
                  ),
                ),
                Spacer(),
                CustomElevatedButton(
                  height: 36.h,
                  width: 84.h,
                  text: "lbl_beach".tr,
                  buttonStyle: CustomButtonStyles.fillPrimaryTL18,
                  buttonTextStyle: theme.textTheme.labelLarge!,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: CustomIconButton(
                    height: 36.h,
                    width: 36.h,
                    padding: EdgeInsets.all(6.h),
                    decoration: IconButtonStyleHelper.fillPrimaryLR18,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgClose,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 32.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 8.h),
            child: Row(
              children: [
                Obx(
                  () => CustomImageView(
                    imagePath: listsectionItemModelObj.reviews!.value,
                    height: 16.h,
                    width: 16.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Obx(
                    () => Text(
                      listsectionItemModelObj.reviewsCounter!.value,
                      style: CustomTextStyles.bodySmallAmber600,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Obx(
              () => Text(
                listsectionItemModelObj.text!.value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall!.copyWith(
                  height: 1.67,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h)
        ],
      ),
    );
  }
}
