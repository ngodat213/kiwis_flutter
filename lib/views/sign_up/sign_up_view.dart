import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/core/constants/app.button_style.dart';
import 'package:kiwis_flutter/views/sign_up/sign_up_controller.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:kiwis_flutter/widgets/custom_floating_text_field.dart';

// ignore_for_file: must_be_immutable
class SignUpScreen extends BaseView<SignUpController> {
  SignUpScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget body(BuildContext context) {
    return Container(
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
            style: CustomTextStyles.titleSmallGoogleSansMediumOnPrimary,
          ),
          SizedBox(height: 38.h),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder24,
            ),
            child: Column(
              children: [
                _buildEmailInput(context),
                SizedBox(height: 4.h),
                _buildPasswordInput(context),
                SizedBox(height: 4.h),
                _buildFirstNameInput(context),
                SizedBox(height: 4.h),
                _buildLastNameInput(context)
              ],
            ),
          ),
          SizedBox(height: 36.h),
          CustomElevatedButton(
            height: 48,
            text: "lbl_sign_up".tr,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            buttonStyle: CustomButtonStyles.fillOnPrimaryTL28,
            onPressed: () => controller.onSignUpButtonPressed(context),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildEmailInput(BuildContext context) {
    return CustomFloatingTextField(
      controller: controller.emailTEC,
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
          controller.showSnackBarWarning(
              "err_msg_please_enter_valid_email".tr, context);
          return "err_msg_please_enter_valid_email".tr;
        }
        return null;
      },
    );
  }

  /// Section Widget
  Widget _buildPasswordInput(BuildContext context) {
    return Obx(
      () => CustomFloatingTextField(
        controller: controller.passwordTEC,
        labelText: "lbl_password".tr,
        labelStyle: theme.textTheme.bodySmall!,
        hintText: "lbl_password".tr,
        textInputType: TextInputType.visiblePassword,
        obscureText: controller.isShowPassword.value,
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
              imagePath: ImageConstant.svgPrivacy,
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
            controller.showSnackBarWarning(
                "err_msg_please_enter_valid_password".tr, context);
            return "err_msg_please_enter_valid_password".tr;
          }
          return null;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildFirstNameInput(BuildContext context) {
    return CustomFloatingTextField(
      controller: controller.firstNameTEC,
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
          controller.showSnackBarWarning(
              "err_msg_please_enter_valid_text".tr, context);
          return "err_msg_please_enter_valid_text".tr;
        }
        return null;
      },
    );
  }

  /// Section Widget
  Widget _buildLastNameInput(BuildContext context) {
    return CustomFloatingTextField(
      controller: controller.lastNameTEC,
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
          controller.showSnackBarWarning(
              "err_msg_please_enter_valid_text".tr, context);
          return "err_msg_please_enter_valid_text".tr;
        }
        return null;
      },
    );
  }
}
