import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/views/sign_up/sign_up_controller.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_leadingiconbutton.dart';
import 'package:kiwis_flutter/widgets/app_bar/app_bar_title.dart';
import 'package:kiwis_flutter/widgets/app_bar/custom_app_bar.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SignUpScreen extends BaseView<SignUpController> {
  SignUpScreen({Key? key})
      : super(
          key: key,
        );

  /// Section Widget
  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Get.height * 0.13),
      child: Container(
        padding: EdgeInsets.only(top: 23),
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: CustomAppBar(
          leadingWidth: 44.h,
          leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgArrowLeftOnprimary,
            onTap: () {
              Get.back();
            },
          ),
          title: AppbarTitle(
            text: "Sign Up".tr,
            margin: EdgeInsets.only(left: 16.h),
          ),
        ),
      ),
    );
  }

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
                _buildFirstNameInput(context),
                SizedBox(height: 4.h),
                _buildLastNameInput(context),
                SizedBox(height: 4.h),
                _buildPhoneInput(context),
                SizedBox(height: 4.h),
                _buildPasswordInput(context),
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

  Widget _buildPhoneInput(BuildContext context) {
    return CustomTextFormField(
      controller: controller.phoneTEC,
      hintText: "Phone",
      height: 56 + 16,
      contentPadding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 23.h),
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.h),
      ),
      validator: (value) {
        if (!isText(value)) {
          controller.showSnackBarWarning(
              "err_msg_please_enter_valid_phone".tr, context);
          return "err_msg_please_enter_valid_phone".tr;
        }
        return null;
      },
    );
  }
}
