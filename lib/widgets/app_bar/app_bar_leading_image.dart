import 'package:flutter/material.dart';
import '../../core/constants/app_export.dart';

class AppbarLeadingImage extends StatelessWidget {
  AppbarLeadingImage({Key? key, this.imagePath, this.onTap, this.margin})
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
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: CustomImageView(
          imagePath: imagePath!,
          height: 24.h,
          width: 24.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
