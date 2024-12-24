import 'package:flutter/material.dart';
import '../../core/constants/app_export.dart';
import '../custom_icon_button.dart';

class AppbarLeadingIconbutton extends StatelessWidget {
  AppbarLeadingIconbutton({
    Key? key,
    this.imagePath,
    this.wiget,
    this.decoration,
    this.onTap,
    this.margin,
  }) : super(
          key: key,
        );
  final BoxDecoration? decoration;
  final String? imagePath;
  final Widget? wiget;
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
          padding: EdgeInsets.all(10.h),
          decoration: decoration,
          child: wiget != null
              ? wiget!
              : CustomImageView(
                  imagePath: imagePath,
                  color: appTheme.black,
                ),
        ),
      ),
    );
  }
}
