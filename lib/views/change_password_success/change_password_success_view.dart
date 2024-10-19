import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/change_password_success/change_password_success_controller.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';

// ignore_for_file: must_be_immutable
class ChangePasswordSuccessBottomsheet extends StatelessWidget {
  ChangePasswordSuccessBottomsheet(this.controller, {Key? key})
      : super(
          key: key,
        );

  ChangePasswordSuccessController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(8.h),
      child: Column(
        children: [
          SizedBox(height: 286.h),
          SizedBox(
            width: double.maxFinite,
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              margin: EdgeInsets.zero,
              color: appTheme.gray900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusStyle.roundedBorder44,
              ),
              child: Container(
                height: 496.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: appTheme.gray900,
                  borderRadius: BorderRadiusStyle.roundedBorder44,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [_buildImageRow()],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8.h),
                          child: CustomIconButton(
                            height: 40.h,
                            width: 40.h,
                            padding: EdgeInsets.all(8.h),
                            decoration: IconButtonStyleHelper.fillOnPrimaryTL20,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgCloseOnprimary,
                            ),
                          ),
                        ),
                        SizedBox(height: 56.h),
                        _buildVerificationColumn()
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildImageRow() {
    return SizedBox(
      width: double.maxFinite,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomImageView(
                  imagePath: ImageConstant.imgEllipse20381,
                  height: 198.h,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildVerificationColumn() {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 4.h,
                  width: 4.h,
                  margin: EdgeInsets.only(right: 42.h),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(
                      2.h,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                height: 4.h,
                width: 4.h,
                margin: EdgeInsets.only(left: 36.h),
                decoration: BoxDecoration(
                  color: appTheme.green600,
                  borderRadius: BorderRadius.circular(
                    2.h,
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 2.h,
                    width: 2.h,
                    margin: EdgeInsets.only(top: 16.h),
                    decoration: BoxDecoration(
                      color: appTheme.green600,
                      borderRadius: BorderRadius.circular(
                        1.h,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 6.h,
                      width: 6.h,
                      margin: EdgeInsets.only(
                        left: 18.h,
                        bottom: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(
                          3.h,
                        ),
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgLockGreen300,
                    height: 56.h,
                    width: 56.h,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 12.h),
                  ),
                  Container(
                    height: 10.h,
                    width: 10.h,
                    margin: EdgeInsets.only(
                      left: 16.h,
                      top: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: appTheme.green300,
                      borderRadius: BorderRadius.circular(
                        4.h,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 2.h,
                      width: 2.h,
                      margin: EdgeInsets.only(
                        left: 12.h,
                        bottom: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: appTheme.green600,
                        borderRadius: BorderRadius.circular(
                          1.h,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 6.h),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 4.h,
                  width: 4.h,
                  margin: EdgeInsets.only(right: 36.h),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(
                      2.h,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                height: 2.h,
                width: 2.h,
                margin: EdgeInsets.only(left: 38.h),
                decoration: BoxDecoration(
                  color: appTheme.green600,
                  borderRadius: BorderRadius.circular(
                    1.h,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 50.h),
          Text(
            "lbl_successfully".tr,
            style: theme.textTheme.headlineLarge,
          ),
          SizedBox(height: 20.h),
          Text(
            "msg_you_have_been_changed".tr,
            style: CustomTextStyles.titleSmallGoogleSansMediumOnPrimary,
          ),
          SizedBox(height: 48.h),
          CustomElevatedButton(
            text: "lbl_login_again".tr,
            buttonStyle: CustomButtonStyles.fillGreen,
          )
        ],
      ),
    );
  }
}
