import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(28.h),
      );
  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(28.h),
      );
  static BoxDecoration get fillOnPrimaryTL28 => BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(28.h),
      );
  static BoxDecoration get fillOnPrimaryTL20 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20.h),
      );
  static BoxDecoration get fillGreen => BoxDecoration(
        color: appTheme.green300,
        borderRadius: BorderRadius.circular(16.h),
      );
  static BoxDecoration get fillPrimaryLR18 => BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            4.h,
          ),
          topRight: Radius.circular(
            18.h,
          ),
          bottomLeft: Radius.circular(
            4.h,
          ),
          bottomRight: Radius.circular(
            18.h,
          ),
        ),
      );
  static BoxDecoration get fillOnPrimaryLR18 => BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            4.h,
          ),
          topRight: Radius.circular(
            18.h,
          ),
          bottomLeft: Radius.circular(
            4.h,
          ),
          bottomRight: Radius.circular(
            18.h,
          ),
        ),
      );
  static BoxDecoration get fillOnPrimaryTL8 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        borderRadius: BorderRadius.circular(8.h),
      );
  static BoxDecoration get fillOnPrimaryTL24 => BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(24.h),
      );
  static BoxDecoration get fillOnPrimaryTL241 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(24.h),
      );
  static BoxDecoration get fillGreenTL24 => BoxDecoration(
        color: appTheme.green600,
        borderRadius: BorderRadius.circular(24.h),
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray5002,
        borderRadius: BorderRadius.circular(24.h),
      );
  static BoxDecoration get fillPinkA => BoxDecoration(
        color: appTheme.pinkA100,
        borderRadius: BorderRadius.circular(14.h),
      );
  static BoxDecoration get fillGreenTL14 => BoxDecoration(
        color: appTheme.green600,
        borderRadius: BorderRadius.circular(14.h),
      );
  static BoxDecoration get fillOnPrimaryTL202 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        borderRadius: BorderRadius.circular(20.h),
      );
  static BoxDecoration get fillOnPrimaryTL281 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        borderRadius: BorderRadius.circular(28.h),
      );
  static BoxDecoration get fillGrayTL28 => BoxDecoration(
        color: appTheme.gray800,
        borderRadius: BorderRadius.circular(28.h),
      );
  static BoxDecoration get fillPrimaryTL24 => BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(24.h),
      );
  static BoxDecoration get fillPinkATL20 => BoxDecoration(
        color: appTheme.pinkA100,
        borderRadius: BorderRadius.circular(20.h),
      );
  static BoxDecoration get fillAmber => BoxDecoration(
        color: appTheme.amber600,
        borderRadius: BorderRadius.circular(22.h),
      );
  static BoxDecoration get fillOnPrimaryTL14 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(14.h),
      );
  static BoxDecoration get none => BoxDecoration();
}

class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {Key? key,
      this.alignment,
      this.height,
      this.width,
      this.decoration,
      this.padding,
      this.onTap,
      this.child})
      : super(
          key: key,
        );

  final Alignment? alignment;

  final double? height;

  final double? width;

  final BoxDecoration? decoration;

  final EdgeInsetsGeometry? padding;

  final VoidCallback? onTap;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center, child: iconButtonWidget)
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: DecoratedBox(
          decoration: decoration ??
              BoxDecoration(
                color: theme.colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(20.h),
              ),
          child: IconButton(
            padding: padding ?? EdgeInsets.zero,
            onPressed: onTap,
            icon: child ?? Container(),
          ),
        ),
      );
}
