import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/sign_up/sign_up_controller.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_floating_text_field.dart';

// ignore_for_file: must_be_immutable
class SignUpScreen extends GetWidget<SignUpController> {
  SignUpScreen({Key? key})
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
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(bottom: 48.h),
                      padding: EdgeInsets.symmetric(horizontal: 32.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "lbl_wellcome".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "lbl_sign_in".tr,
                            style: theme.textTheme.displayMedium,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "msg_please_fill_your".tr,
                            style: CustomTextStyles
                                .titleSmallGoogleSansMediumOnPrimary,
                          ),
                          SizedBox(height: 38.h),
                          Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusStyle.roundedBorder24,
                            ),
                            child: Column(
                              children: [
                                _buildEmailInput(),
                                SizedBox(height: 4.h),
                                _buildPasswordInput(),
                                SizedBox(height: 4.h),
                                _buildFirstNameInput(),
                                SizedBox(height: 4.h),
                                _buildLastNameInput()
                              ],
                            ),
                          ),
                          SizedBox(height: 36.h),
                          Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(horizontal: 62.h),
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadiusStyle.circleBorder28,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "lbl_done".tr,
                                  style: theme.textTheme.titleMedium,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgEllipse2005,
                      height: 280.h,
                      width: 274.h,
                      alignment: Alignment.topRight,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgEllipse2006,
                      height: 340.h,
                      width: 240.h,
                      alignment: Alignment.bottomLeft,
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
  Widget _buildEmailInput() {
    return CustomFloatingTextField(
      controller: controller.emailInputController,
      labelText: "lbl_email".tr,
      labelStyle: theme.textTheme.titleMedium!,
      hintText: "lbl_email".tr,
      textInputType: TextInputType.emailAddress,
      suffix: Container(
        margin: EdgeInsets.fromLTRB(12.h, 38.h, 24.h, 38.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgMail,
          height: 24.h,
          width: 24.h,
          fit: BoxFit.contain,
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 100.h,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 24.h,
        vertical: 38.h,
      ),
      validator: (value) {
        if (value == null || (!isValidEmail(value, isRequired: true))) {
          return "err_msg_please_enter_valid_email".tr;
        }
        return null;
      },
    );
  }

  /// Section Widget
  Widget _buildPasswordInput() {
    return Obx(
      () => CustomFloatingTextField(
        controller: controller.passwordInputController,
        labelText: "lbl_password".tr,
        labelStyle: theme.textTheme.bodySmall!,
        hintText: "lbl_password".tr,
        textInputType: TextInputType.visiblePassword,
        obscureText: controller.isShowPassword.value,
        prefix: Container(
          width: 6.h,
          margin: EdgeInsets.only(right: 16.h),
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary.withOpacity(1),
          ),
        ),
        prefixConstraints: BoxConstraints(
          maxHeight: 100.h,
        ),
        suffix: InkWell(
          onTap: () {
            controller.isShowPassword.value = !controller.isShowPassword.value;
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(12.h, 38.h, 24.h, 38.h),
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
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24.h,
          vertical: 38.h,
        ),
        validator: (value) {
          if (value == null || (!isValidPassword(value, isRequired: true))) {
            return "err_msg_please_enter_valid_password".tr;
          }
          return null;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildFirstNameInput() {
    return CustomFloatingTextField(
      controller: controller.firstNameInputController,
      labelText: "lbl_first_name".tr,
      labelStyle: theme.textTheme.titleMedium!,
      hintText: "lbl_first_name".tr,
      suffix: Container(
        margin: EdgeInsets.fromLTRB(12.h, 38.h, 24.h, 38.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgUser24x24,
          height: 24.h,
          width: 24.h,
          fit: BoxFit.contain,
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 100.h,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 24.h,
        vertical: 38.h,
      ),
      validator: (value) {
        if (!isText(value)) {
          return "err_msg_please_enter_valid_text".tr;
        }
        return null;
      },
    );
  }

  /// Section Widget
  Widget _buildLastNameInput() {
    return CustomFloatingTextField(
      controller: controller.lastNameInputController,
      labelText: "lbl_last_name2".tr,
      labelStyle: theme.textTheme.titleMedium!,
      hintText: "lbl_last_name2".tr,
      textInputAction: TextInputAction.done,
      suffix: Container(
        margin: EdgeInsets.fromLTRB(12.h, 38.h, 24.h, 38.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgUser24x24,
          height: 24.h,
          width: 24.h,
          fit: BoxFit.contain,
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 100.h,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 24.h,
        vertical: 38.h,
      ),
      validator: (value) {
        if (!isText(value)) {
          return "err_msg_please_enter_valid_text".tr;
        }
        return null;
      },
    );
  }
}
