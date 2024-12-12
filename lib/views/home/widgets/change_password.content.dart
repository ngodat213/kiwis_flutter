import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/home/home_controller.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class ChangePasswordContent extends GetView<HomeController> {
  ChangePasswordContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.6,
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
      decoration: BoxDecoration(
        color: appTheme.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.h),
          topRight: Radius.circular(16.h),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30.h,
            height: 5.h,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(100),
            ),
          ).centered(),
          SizedBox(height: 32.h),
          "Change password"
              .text
              .textStyle(CustomTextStyles.titleMedium19)
              .make(),
          SizedBox(height: 16.h),
          "Change your password to secure your account"
              .text
              .textStyle(CustomTextStyles.labelLargeOnPrimary)
              .make(),
          SizedBox(height: 16.h),
          CustomTextFormField(
            controller: controller.currentPasswordTEC,
            hintText: "Enter current password",
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 18.h,
            ),
          ),
          SizedBox(height: 16.h),
          CustomTextFormField(
            controller: controller.newPasswordTEC,
            hintText: "Enter new password",
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 18.h,
            ),
          ),
          SizedBox(height: 16.h),
          CustomTextFormField(
            controller: controller.confirmPasswordTEC,
            obscureText: true,
            textInputType: TextInputType.visiblePassword,
            hintText: "Enter confirm password",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 18.h,
            ),
          ),
          SizedBox(height: 32.h),
          CustomElevatedButton(
            text: "Save".tr,
            onPressed: () => controller.handlePassword(context),
          ),
        ],
      ),
    );
  }
}
