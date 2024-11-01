import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/sign_in/sign_in_controller.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_floating_text_field.dart';

// ignore_for_file: must_be_immutable
class SignInScreen extends GetWidget<SignInController> {
  SignInScreen({Key? key})
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
                  alignment: Alignment.center,
                  children: [
                    Container(
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
                                    borderRadius:
                                        BorderRadiusStyle.customBorderTL14,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RotationTransition(
                                        turns: AlwaysStoppedAnimation(
                                          -(90 / 360),
                                        ),
                                        child: Text(
                                          "lbl_t".tr,
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10.h),
                                Text(
                                  "lbl_travee".tr,
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
                            style: CustomTextStyles
                                .titleSmallGoogleSansMediumOnPrimary,
                          ),
                          SizedBox(height: 56.h),
                          _buildEmailPasswordFields(),
                          SizedBox(height: 56.h),
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
                                  "lbl_sign_in_now".tr,
                                  style: theme.textTheme.titleMedium,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 32.h),
                          GestureDetector(
                            onTap: () {
                              print("Sign up button pressed");
                              controller.onSignUpButtonPressed();
                            },
                            child: Text(
                              "lbl_sign_up".tr,
                              style: theme.textTheme.titleMedium,
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
                      imagePath: ImageConstant.imgEllipse2006Green600516x342,
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
  Widget _buildEmailPasswordFields() {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        children: [
          CustomFloatingTextField(
            isTop: true,
            controller: controller.emailController,
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
              controller: controller.passwordController,
              labelText: "lbl_password".tr,
              labelStyle: theme.textTheme.bodySmall!,
              hintText: "lbl_password".tr,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.visiblePassword,
              obscureText: controller.isShowPassword.value,
              prefixConstraints: BoxConstraints(
                maxHeight: 100.h,
              ),
              suffix: InkWell(
                onTap: () {
                  controller.isShowPassword.value =
                      !controller.isShowPassword.value;
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
}
