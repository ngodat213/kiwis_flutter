import 'package:flutter/material.dart';
import '../../core/constants/app_export.dart';
import '../custom_icon_button.dart';

class AppbarTrailingIconbutton extends StatelessWidget {
  AppbarTrailingIconbutton({Key? key, this.imagePath, this.onTap, this.margin})
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
          padding: EdgeInsets.all(10.h),
          child: CustomImageView(
            imagePath: imagePath,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
