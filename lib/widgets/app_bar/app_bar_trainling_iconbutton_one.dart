import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../custom_icon_button.dart';

class AppbarTrailingIconbuttonOne extends StatelessWidget {
  AppbarTrailingIconbuttonOne(
      {Key? key, this.imagePath, this.onTap, this.margin, this.color})
      : super(
          key: key,
        );

  final String? imagePath;

  final Function? onTap;

  final Color? color;

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
          padding: EdgeInsets.all(10.h),
          child: CustomImageView(
            color: color ?? Colors.white,
            imagePath: ImageConstant.svgMore,
          ),
        ),
      ),
    );
  }
}
