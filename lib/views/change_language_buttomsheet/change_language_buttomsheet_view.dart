import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/change_language_buttomsheet/change_language_buttomsheet_controller.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';

// ignore_for_file: must_be_immutable
class ChangeListviewBottomsheet extends StatelessWidget {
  ChangeListviewBottomsheet(this.controller, {Key? key})
      : super(
          key: key,
        );

  ChangeLanguageButtomsheetController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(8.h),
      child: Column(
        children: [
          SizedBox(height: 354.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(
              left: 24.h,
              top: 24.h,
              right: 24.h,
            ),
            decoration: BoxDecoration(
              color: appTheme.gray900,
              borderRadius: BorderRadiusStyle.roundedBorder44,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 8.h),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(horizontal: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: Text(
                            "lbl_layout".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 84.h),
                        child: CustomIconButton(
                          height: 40.h,
                          width: 40.h,
                          padding: EdgeInsets.all(8.h),
                          decoration: IconButtonStyleHelper.fillOnPrimaryTL20,
                          child: CustomImageView(
                            imagePath: ImageConstant.imgCloseOnprimary,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 28.h),
                _buildChangeListViewSection(),
                SizedBox(height: 28.h),
                CustomElevatedButton(
                  text: "lbl_done".tr,
                  buttonStyle: CustomButtonStyles.fillPrimary,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildChangeListViewSection() {
    return Obx(
      () => ListView.separated(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 12.h,
          );
        },
        itemCount: controller.changeListviewModelObj.value
            .changelistviewsectionItemList.value.length,
        itemBuilder: (context, index) {
          ChangelistviewsectionItemModel model = controller
              .changeListviewModelObj
              .value
              .changelistviewsectionItemList
              .value[index];
          return ChangelistviewsectionItemWidget(
            model,
          );
        },
      ),
    );
  }
}

i