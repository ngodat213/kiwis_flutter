import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/home/home_controller.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:kiwis_flutter/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class DeleteAccountContent extends GetView<HomeController> {
  DeleteAccountContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.4,
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
          "Delete account"
              .text
              .textStyle(CustomTextStyles.titleMedium19)
              .make(),
          SizedBox(height: 16.h),
          "Are you sure you want to delete your account? All your data will be deleted and you will not be able to access your account."
              .text
              .textStyle(CustomTextStyles.bodyMediumGoogleSansMediumOnPrimary)
              .make(),
          SizedBox(height: 16.h),
          Obx(
            () => Row(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.isDeleteAccount.value =
                        !controller.isDeleteAccount.value;
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: controller.isDeleteAccount.value
                          ? Colors.blue
                          : Colors.transparent,
                      border: Border.all(
                        color: controller.isDeleteAccount.value
                            ? Colors.blue
                            : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: controller.isDeleteAccount.value
                        ? Icon(Icons.check, size: 18, color: Colors.white)
                        : null,
                  ),
                ),
                SizedBox(width: 8),
                "I agree to delete my account"
                    .text
                    .textStyle(
                        CustomTextStyles.bodyMediumGoogleSansMediumOnPrimary)
                    .make(),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          CustomElevatedButton(
            text: "Save".tr,
            onPressed: () => controller.handleDeleteAccount(context),
          ),
        ],
      ),
    );
  }
}
