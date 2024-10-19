import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../custom_icon_button.dart';

class AppbarTrailingIconbuttonTwo extends StatelessWidget {
  AppbarTrailingIconbuttonTwo(
      {Key? key, this.imagePath, this.onTap, this.margin})
      : super(
          key: key,
        );

  final String? imagePath;

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
        child: CustomIconButton(
          height: 44.h,
          width: 44.h,
          padding: EdgeInsets.all(6.h),
          decoration: IconButtonStyleHelper.fillOnPrimaryTL8,
          child: CustomImageView(
            imagePath: ImageConstant.imgArrowDownCircle,
          ),
        ),
      ),
    );
  }
}
