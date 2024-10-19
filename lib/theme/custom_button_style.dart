import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/app_export.dart';
import 'package:kiwis_flutter/core/utils/size.utils.dart';
import 'package:kiwis_flutter/theme/theme_helper.dart';

/// A class that offers pre-defined styles for customizing button appearance.
class CustomButtonStyles {
  /// Filled button style
  static ButtonStyle get fillAmber => ElevatedButton.styleFrom(
        backgroundColor: appTheme.amber600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get fillCyan => ElevatedButton.styleFrom(
        backgroundColor: appTheme.cyan500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get fillGreen => ElevatedButton.styleFrom(
        backgroundColor: appTheme.green600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get fillOnprimaryTl18 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.h),
            topRight: Radius.circular(4.h),
            bottomLeft: Radius.circular(18.h),
            bottomRight: Radius.circular(4.h),
          ),
        ),
      );

  static ButtonStyle get fillOnprimaryTl181 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.colorScheme.onPrimary.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.h),
          ),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );
  static ButtonStyle get fillOnPrimaryTl182 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.colorScheme.onPrimary.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.h),
          ),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get fillOnPrimaryTl183 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.h),
          ),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get fillOnPrimaryTl128 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.colorScheme.onPrimary.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get fillPrimary => ElevatedButton.styleFrom(
        backgroundColor: appTheme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get fillPrimaryTl18 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.h),
            topRight: Radius.circular(4.h),
            bottomLeft: Radius.circular(18.h),
            bottomRight: Radius.circular(4.h),
          ),
        ),
      );

  static ButtonStyle get fillPrimaryTl20 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get fillPrimaryTl36 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get none => ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
        elevation: WidgetStateProperty.all<double>(0),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
        side: WidgetStateProperty.all<BorderSide>(
          BorderSide(color: Colors.transparent),
        ),
      );
}
