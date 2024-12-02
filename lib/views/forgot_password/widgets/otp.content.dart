import 'package:flutter/cupertino.dart';
import 'package:kiwis_flutter/core/base/base.view.dart';
import 'package:kiwis_flutter/core/constants/app.button_style.dart';
import 'package:kiwis_flutter/views/forgot_password/forgot_password_controller.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';

class OtpContent extends BaseView<ForgotPasswordController> {
  OtpContent({super.key});

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
            "Verification Code".tr,
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 2.h),
          Text(
            "We texted your a code. Please enter it below".tr,
            style: theme.textTheme.displayMedium,
          ),
          SizedBox(height: 38.h),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder24,
            ),
            child: Column(
              children: [
                _buildOtpInput(context),
              ],
            ),
          ),
          SizedBox(height: 36.h),
          CustomElevatedButton(
            height: 48,
            text: "Confirm".tr,
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
  Widget _buildOtpInput(BuildContext context) {
    return OTPTextField(
      length: 5,
      width: MediaQuery.of(context).size.width,
      fieldWidth: 80,
      style: TextStyle(fontSize: 17),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
      },
    );
  }
}
