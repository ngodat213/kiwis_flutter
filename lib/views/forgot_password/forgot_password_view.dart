import 'package:flutter/material.dart';

import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/core/constants/app.button_style.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:kiwis_flutter/widgets/custom_floating_text_field.dart';

import 'forgot_password_controller.dart';

class ForgotPasswordView extends BaseView<ForgotPasswordController> {
  ForgotPasswordView({super.key});

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
            "Forgot password".tr,
            style: theme.textTheme.displayMedium,
          ),
          SizedBox(height: 2.h),
          Text(
            "Please fill your email".tr,
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
            onPressed: () => controller.onPressedForgotPassword(context),
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
          // controller.show(
          //     "err_msg_please_enter_valid_email".tr, context);
          return "err_msg_please_enter_valid_email".tr;
        }
        return null;
      },
    );
  }
}
