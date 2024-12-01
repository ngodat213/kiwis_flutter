import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/core/constants/app.button_style.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/sign_in/sign_in_controller.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:kiwis_flutter/helper/validation.dart';

// ignore: must_be_immutable
class SignInScreen extends BaseView<SignInController> {
  SignInScreen({super.key});

  @override
  Widget body(BuildContext context) {
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
            controller: controller,
          ),
          GestureDetector(
            onTap: () => controller.onPressedForgotPassword(),
            child: Align(
              alignment: Alignment.topRight,
              child: "Forgot password"
                  .tr
                  .text
                  .textStyle(theme.textTheme.titleMedium)
                  .bold
                  .white
                  .make(),
            ).pOnly(bottom: 32, top: 8),
          ),
          CustomElevatedButton(
            height: 48,
            text: "lbl_sign_in_now".tr,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            buttonStyle: CustomButtonStyles.fillOnPrimaryTL28,
            onPressed: () => controller.onSignInButtonPressed(context),
          ),
          SizedBox(height: 32.h),
          "- Or Sign in with"
              .tr
              .text
              .textStyle(theme.textTheme.titleSmall)
              .make()
              .paddingOnly(bottom: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                height: 48,
                width: Get.width * 0.25,
                text: "Google".tr,
                buttonTextStyle: theme.textTheme.titleSmall,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                buttonStyle: CustomButtonStyles.fillOnPrimaryTL28,
              ),
              CustomElevatedButton(
                height: 48,
                width: Get.width * 0.25,
                text: "Facebook".tr,
                buttonTextStyle: theme.textTheme.titleSmall,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                buttonStyle: CustomButtonStyles.fillOnPrimaryTL28,
              ),
            ],
          ).paddingOnly(bottom: 32),
          GestureDetector(
            onTap: () => controller.onSignUpButtonPressed(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ".tr,
                  style: theme.textTheme.titleSmall,
                ),
                Text(
                  "Register Now".tr,
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/// Section Widget
Widget _buildEmailPasswordFields({
  required SignInController controller,
}) {
  return Container(
    width: double.maxFinite,
    decoration: BoxDecoration(
      borderRadius: BorderRadiusStyle.roundedBorder24,
    ),
    child: Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(
            hintText: "Email",
            height: 56 + 16,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 23.h, vertical: 23.h),
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.h),
            ),
            validator: Validators.validateEmail,
            controller: controller.emailTxtController,
          ).marginOnly(bottom: 8),
          CustomTextFormField(
            hintText: "Password",
            height: 56 + 16,
            textInputType: TextInputType.visiblePassword,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 23.h, vertical: 23.h),
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.h),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              return null;
            },
            controller: controller.passwordTxtController,
          ),
        ],
      ),
    ),
  );
}
