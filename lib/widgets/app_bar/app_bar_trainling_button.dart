import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../custom_elevated_button.dart';

class AppbarTrailingButton extends StatelessWidget {
  AppbarTrailingButton({Key? key, this.onTap, this.margin})
      : super(
          key: key,
        );

  final Function? onTap;

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: CustomElevatedButton(
          height: 40.h,
          width: 108.h,
          text: "lbl_update".tr,
          buttonStyle: CustomButtonStyles.fillPrimaryTL20,
          buttonTextStyle: theme.textTheme.titleSmall!,
        ),
      ),
    );
  }
}
