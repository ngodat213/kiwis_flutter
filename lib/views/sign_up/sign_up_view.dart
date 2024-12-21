import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/core/constants/app.button_style.dart';
import 'package:kiwis_flutter/views/sign_up/sign_up_controller.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:kiwis_flutter/widgets/custom_floating_text_field.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';

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
              color: appTheme.green600,
              borderRadius: BorderRadius.circular(10),
            ),
            buttonTextStyle: theme.textTheme.titleSmall!.copyWith(
              color: Colors.white,
            ),
            onPressed: () => controller.onSignUpButtonPressed(context),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildEmailInput(BuildContext context) {
    return CustomTextFormField(
      controller: controller.emailTEC,
      hintText: "Email",
      height: 56 + 16,
      contentPadding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 23.h),
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.h),
      ),
      textInputType: TextInputType.emailAddress,
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
      () => CustomTextFormField(
        controller: controller.passwordTEC,
        hintText: "Password",
        height: 56 + 16,
        contentPadding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 23.h),
        boxDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.h),
        ),
        textInputType: TextInputType.visiblePassword,
        obscureText: controller.isShowPassword.value,
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
    return CustomTextFormField(
      controller: controller.firstNameTEC,
      hintText: "First Name",
      height: 56 + 16,
      contentPadding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 23.h),
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.h),
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
    return CustomTextFormField(
      controller: controller.lastNameTEC,
      hintText: "Last Name",
      height: 56 + 16,
      contentPadding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 23.h),
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.h),
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
