import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/widgets/custom_floating_text_field.dart';

class SignInContent extends StatelessWidget {
  const SignInContent({
    super.key,
    required this.emailTxtController,
    required this.passwordTxtController,
    required this.onSignInButtonPressed,
    required this.onSignUpButtonPressed,
    required this.isShowPassword,
  });
  final TextEditingController emailTxtController;
  final TextEditingController passwordTxtController;

  final Function() onSignInButtonPressed;
  final Function() onSignUpButtonPressed;
  final RxBool isShowPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 110.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 28.h,
                  width: 28.h,
                  decoration: BoxDecoration(
                    color: appTheme.green300,
                    borderRadius: BorderRadiusStyle.customBorderTL14,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "k".tr,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.h),
                Text(
                  "kiwis".tr,
                  style: theme.textTheme.headlineMedium,
                )
              ],
            ),
          ),
          SizedBox(height: 54.h),
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
          SizedBox(height: 56.h),
          _buildEmailPasswordFields(
            emailTextFieldController: emailTxtController,
            passwordTextFieldController: passwordTxtController,
            isShowPassword: isShowPassword,
          ),
          SizedBox(height: 56.h),
          GestureDetector(
            onTap: onSignInButtonPressed,
            child: Container(
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
                    "lbl_sign_in_now".tr,
                    style: theme.textTheme.titleMedium,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 32.h),
          GestureDetector(
            onTap: onSignUpButtonPressed,
            child: Text(
              "lbl_sign_up".tr,
              style: theme.textTheme.titleMedium,
            ),
          )
        ],
      ),
    );
  }
}

/// Section Widget
Widget _buildEmailPasswordFields({
  required TextEditingController emailTextFieldController,
  required TextEditingController passwordTextFieldController,
  required RxBool isShowPassword,
}) {
  return Container(
    width: double.maxFinite,
    decoration: BoxDecoration(
      borderRadius: BorderRadiusStyle.roundedBorder24,
    ),
    child: Column(
      children: [
        CustomFloatingTextField(
          isTop: true,
          controller: emailTextFieldController,
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
          validator: (value) {
            if (value == null || (!isValidEmail(value, isRequired: true))) {
              return "err_msg_please_enter_valid_email".tr;
            }
            return null;
          },
        ),
        SizedBox(height: 4.h),
        Obx(
          () => CustomFloatingTextField(
            isBottom: true,
            controller: passwordTextFieldController,
            labelText: "lbl_password".tr,
            labelStyle: theme.textTheme.bodySmall!,
            hintText: "lbl_password".tr,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            obscureText: isShowPassword.value,
            prefixConstraints: BoxConstraints(
              maxHeight: 100.h,
            ),
            suffix: InkWell(
              onTap: () {
                isShowPassword.value = !isShowPassword.value;
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
            validator: (value) {
              if (value == null ||
                  (!isValidPassword(value, isRequired: true))) {
                return "err_msg_please_enter_valid_password".tr;
              }
              return null;
            },
          ),
        )
      ],
    ),
  );
}
