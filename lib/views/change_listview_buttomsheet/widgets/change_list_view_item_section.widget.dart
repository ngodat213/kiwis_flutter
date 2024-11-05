import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/change_listview_buttomsheet/change_language_buttomsheet_controller.dart';
import 'package:kiwis_flutter/views/change_listview_buttomsheet/models/change_list_view_section_item.model.dart';
import '../../../core/constants/app_export.dart';
import '../../../widgets/custom_icon_button.dart';

// ignore_for_file: must_be_immutable
class ChangelistviewsectionItemWidget extends StatelessWidget {
  ChangelistviewsectionItemWidget(this.changelistviewsectionItemModelObj,
      {Key? key})
      : super(
          key: key,
        );

  ChangeListViewSectionItemModel changelistviewsectionItemModelObj;

  var controller = Get.find<ChangeListViewController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(22.h),
      decoration: BoxDecoration(
        color: appTheme.blueA40019,
        borderRadius: BorderRadiusStyle.circleBorder52,
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 1.h,
          strokeAlign: BorderSide.strokeAlignCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconButton(
            height: 56.h,
            width: 56.h,
            padding: EdgeInsets.all(16.h),
            decoration: IconButtonStyleHelper.fillOnPrimaryTL28,
            child: CustomImageView(
              imagePath: ImageConstant.imgTelevision,
            ),
          ),
          SizedBox(width: 24.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    changelistviewsectionItemModelObj.use!.value,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                SizedBox(height: 4.h),
                Obx(
                  () => Text(
                    changelistviewsectionItemModelObj.listView!.value,
                    style: theme.textTheme.titleMedium,
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 24.h),
          CustomIconButton(
            height: 56.h,
            width: 56.h,
            padding: EdgeInsets.all(16.h),
            decoration: IconButtonStyleHelper.fillOnPrimary,
            child: CustomImageView(
              imagePath: ImageConstant.imgContrast,
            ),
          )
        ],
      ),
    );
  }
}
