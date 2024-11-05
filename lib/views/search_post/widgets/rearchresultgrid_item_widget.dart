import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/search_post/search_post_controller.dart';
import 'package:kiwis_flutter/views/search_post/search_resultgrid_item_model.dart';
import '../../../core/constants/app_export.dart';
import '../../../core/constants/app.button_style.dart';
import '../../../widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class SearchresultsgridItemWidget extends StatelessWidget {
  SearchresultsgridItemWidget(this.searchresultsgridItemModelObj, {Key? key})
      : super(
          key: key,
        );

  SearchresultsgridItemModel searchresultsgridItemModelObj;

  var controller = Get.find<SearchPostController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
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
                          imagePath:
                              searchresultsgridItemModelObj.postInOne!.value,
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
                          searchresultsgridItemModelObj.postInTwo!.value,
                          style: CustomTextStyles
                              .labelLargeGoogleSansMediumOnPrimary,
                        ),
                      ),
                      Obx(
                        () => Text(
                          searchresultsgridItemModelObj.greenwich!.value,
                          style: theme.textTheme.titleSmall,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 22.h),
          SizedBox(
            width: 124.h,
            child: Obx(
              () => Text(
                searchresultsgridItemModelObj.text!.value,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.labelLargeGoogleSansMedium.copyWith(
                  height: 1.67,
                ),
              ),
            ),
          ),
          SizedBox(height: 22.h),
          _buildSeeMoreButton()
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSeeMoreButton() {
    return CustomElevatedButton(
      height: 40.h,
      text: "lbl_see_more".tr,
      buttonStyle: CustomButtonStyles.fillOnPrimaryTL183,
      buttonTextStyle: theme.textTheme.titleSmall!,
    );
  }
}
