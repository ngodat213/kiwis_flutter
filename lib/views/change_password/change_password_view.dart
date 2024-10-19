import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/change_password/change_password_controller.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class ChangePasswordScreen extends GetWidget<ChangePasswordController> {
  ChangePasswordScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Container(
                height: 798.h,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgEllipse2006,
                      height: 340.h,
                      width: 240.h,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgEllipse2005,
                      height: 280.h,
                      width: 274.h,
                      alignment: Alignment.topRight,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: 34.h),
                        padding: EdgeInsets.symmetric(horizontal: 24.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: _buildAppBar(),
                            ),
                            SizedBox(height: 62.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.h),
                                child: Text(
                                  "lbl_change".tr,
                                  style: theme.textTheme.titleLarge,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.h),
                                child: Text(
                                  "lbl_password".tr,
                                  style: theme.textTheme.displayMedium,
                                ),
                              ),
                            ),
                            SizedBox(height: 18.h),
                            _buildPasswordInputSection(),
                            SizedBox(height: 50.h),
                            Container(
                              width: double.maxFinite,
                              margin: EdgeInsets.symmetric(horizontal: 24.h),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: _buildPasswordRequirementCase(
                                      checkmarkThree:
                                          ImageConstant.imgCheckmarkGreen600,
                                      upperlowercasel:
                                          "msg_6_or_more_characters".tr,
                                    ),
                                  ),
                                  SizedBox(height: 18.h),
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: _buildPasswordRequirementCase(
                                      checkmarkThree:
                                          ImageConstant.imgCheckmarkGreen600,
                                      upperlowercasel: "msg_upper_lowercase".tr,
                                    ),
                                  ),
                                  SizedBox(height: 18.h),
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: _buildPasswordRequirementCase(
                                      checkmarkThree:
                                          ImageConstant.imgInterface,
                                      upperlowercasel:
                                          "msg_at_least_1_number".tr,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 44.h,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeftOnprimary,
        onTap: () {
          onTapArrowleftone();
        },
      ),
      actions: [
        AppbarTrailingButton(
          margin: EdgeInsets.only(
            top: 2.h,
            right: 1.h,
            bottom: 2.h,
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildOldPasswordInput() {
    return Obx(
      () => CustomTextFormField(
        hintText: "lbl_old_password".tr,
        textInputType: TextInputType.visiblePassword,
        suffix: InkWell(
          onTap: () {
            controller.isShowPassword.value = !controller.isShowPassword.value;
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(16.h, 38.h, 24.h, 38.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgLock,
              height: 24.h,
              width: 24.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 100.h,
        ),
        obscureText: controller.isShowPassword.value,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24.h,
          vertical: 38.h,
        ),
        validator: (value) {
          if (value == null || (!isValidPassword(value, isRequired: true))) {
            return "err_msg_please_enter_valid_password";
          }
          return null;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildNewPasswordInput() {
    return Obx(
      () => CustomTextFormField(
        controller: controller.newPasswordInputController,
        hintText: "lbl_new_password".tr,
        textInputType: TextInputType.visiblePassword,
        suffix: InkWell(
          onTap: () {
            controller.isShowPassword1.value =
                !controller.isShowPassword1.value;
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(16.h, 38.h, 24.h, 38.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgLock,
              height: 24.h,
              width: 24.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 100.h,
        ),
        obscureText: controller.isShowPassword1.value,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24.h,
          vertical: 38.h,
        ),
        validator: (value) {
          if (value == null || (!isValidPassword(value, isRequired: true))) {
            return "err_msg_please_enter_valid_password";
          }
          return null;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildConfirmNewPasswordInput() {
    return Obx(
      () => CustomTextFormField(
        controller: controller.confirmNewPasswordInputController,
        hintText: "lbl_new_password".tr,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        suffix: InkWell(
          onTap: () {
            controller.isShowPassword2.value =
                !controller.isShowPassword2.value;
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(16.h, 38.h, 24.h, 38.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgCheckmarkGreen600,
              height: 24.h,
              width: 24.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 100.h,
        ),
        obscureText: controller.isShowPassword2.value,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24.h,
          vertical: 38.h,
        ),
        validator: (value) {
          if (value == null || (!isValidPassword(value, isRequired: true))) {
            return "err_msg_please_enter_valid_password";
          }
          return null;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildPasswordInputSection() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        children: [
          _buildOldPasswordInput(),
          SizedBox(height: 4.h),
          _buildNewPasswordInput(),
          SizedBox(height: 4.h),
          _buildConfirmNewPasswordInput()
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildPasswordRequirementCase({
    required String checkmarkThree,
    required String upperlowercasel,
  }) {
    return Row(
      children: [CustomImageView()],
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
