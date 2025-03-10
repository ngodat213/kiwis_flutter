import 'package:flutter/widgets.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';

class AppDecoration {
  /// Color decorations
  static BoxDecoration get colorBase600 => BoxDecoration(
        color: appTheme.gray800,
        boxShadow: [
          BoxShadow(
            color: appTheme.gray800.withOpacity(0.5),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(0, 4),
          ),
        ],
      );

  static BoxDecoration get colorBase700 => BoxDecoration(
        color: appTheme.gray5001,
      );

  static BoxDecoration get colorGray800 => BoxDecoration(
        color: appTheme.gray800,
      );

  static BoxDecoration get colorBase800ColorWhite10 => BoxDecoration(
        color: theme.colorScheme.onPrimary,
        border: Border.all(color: appTheme.gray800, width: 4.h),
        boxShadow: [
          BoxShadow(
            color: appTheme.gray800.withOpacity(0.5),
            spreadRadius: 2.h,
            offset: Offset(0, 4),
          ),
        ],
      );

  static BoxDecoration get colorSecondary900 => BoxDecoration(
        color: appTheme.green600,
      );

  static BoxDecoration get colorSecondary900ColorSecondary900 => BoxDecoration(
        color: appTheme.green600,
        border: Border.all(
          color: appTheme.green600,
          width: 2.h,
        ),
      );

  static BoxDecoration get colorWhite10 => BoxDecoration(
        color: theme.colorScheme.onPrimary,
      );

  static BoxDecoration get colorWhite100 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        border: Border.all(
          color: theme.colorScheme.onPrimary.withOpacity(1),
          width: 3.07.h,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      );

  static BoxDecoration get colorWhite100ColorWhite100 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        border: Border.all(
          color: theme.colorScheme.onPrimary.withOpacity(1),
          width: 1.05.h,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      );

  static BoxDecoration get colorWhite20 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.2),
      );

  static BoxDecoration get colorWhite50 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.5),
      );

  static BoxDecoration get colorWhite5DropshadowMenu => BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: theme.colorScheme.onPrimary.withOpacity(0.05), width: 1.h),
        ),
      );

  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );

  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );

  static BoxDecoration get gradientGreenToGreen => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.23, 0.08),
          end: Alignment(0.5, 1),
          colors: [appTheme.green600, appTheme.green600],
        ),
      );

  static BoxDecoration get outlineOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.onPrimary,
            width: 1.35.h,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
      );

  static BoxDecoration get outlineOnPrimary1 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        border: Border.all(
          color: theme.colorScheme.onPrimary.withOpacity(1),
          width: 1.h,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      );

  static BoxDecoration get outlineOnPrimary2 => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.onPrimary.withOpacity(0.05),
            width: 1.h,
          ),
        ),
      );

  static BoxDecoration get outlineOnPrimary3 => BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.onPrimary,
            width: 1.h,
          ),
        ),
      );

  static BoxDecoration get outlineOnPrimary4 => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.onPrimary,
            width: 1.h,
          ),
        ),
      );

  static BoxDecoration get outlinePrimary => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.onPrimary,
            width: 1.h,
          ),
        ),
      );
}

class BorderRadiusStyle {
  static BorderRadius get circleBorder12 => BorderRadius.circular(12.h);
  static BorderRadius get circleBorder18 => BorderRadius.circular(18.h);
  static BorderRadius get circleBorder28 => BorderRadius.circular(28.h);
  static BorderRadius get circleBorder40 => BorderRadius.circular(40.h);
  static BorderRadius get circleBorder52 => BorderRadius.circular(52.h);
  static BorderRadius get circleBorder90 => BorderRadius.circular(90.h);
  static BorderRadius get customBorderTL10 => BorderRadius.only(
        topLeft: Radius.circular(10.h),
        topRight: Radius.circular(10.h),
        bottomLeft: Radius.circular(1.h),
        bottomRight: Radius.circular(10.h),
      );

  static BorderRadius get customBorderTL14 => BorderRadius.only(
        topLeft: Radius.circular(14.h),
        topRight: Radius.circular(14.h),
        bottomRight: Radius.circular(14.h),
        bottomLeft: Radius.circular(3.h),
      );

  static BorderRadius get customBorderTL20 => BorderRadius.only(
        topLeft: Radius.circular(20.h),
        topRight: Radius.circular(20.h),
        bottomLeft: Radius.circular(2.h),
        bottomRight: Radius.circular(20.h),
      );

  static BorderRadius get customBorderTL24 => BorderRadius.only(
        topLeft: Radius.circular(24.h),
        topRight: Radius.circular(24.h),
        bottomLeft: Radius.circular(12.h),
        bottomRight: Radius.circular(12.h),
      );

  static BorderRadius get customBorderTL28 => BorderRadius.only(
        topLeft: Radius.circular(28.h),
        topRight: Radius.circular(28.h),
        bottomLeft: Radius.circular(4.h),
        bottomRight: Radius.circular(28.h),
      );

  static BorderRadius get customBorderTL6 => BorderRadius.only(
        topLeft: Radius.circular(6.h),
        topRight: Radius.circular(6.h),
        bottomLeft: Radius.circular(1.h),
        bottomRight: Radius.circular(6.h),
      );

  static BorderRadius get customBorderTop28 => BorderRadius.only(
        topLeft: Radius.circular(28.h),
        topRight: Radius.circular(28.h),
        bottomLeft: Radius.circular(8.h),
        bottomRight: Radius.circular(8.h),
      );

  static BorderRadius get customBorderBottom28 => BorderRadius.only(
        topLeft: Radius.circular(8.h),
        topRight: Radius.circular(8.h),
        bottomLeft: Radius.circular(28.h),
        bottomRight: Radius.circular(28.h),
      );

  // Rounded border
  static BorderRadius get roundedBorder194 => BorderRadius.circular(194.h);
  static BorderRadius get roundedBorder24 => BorderRadius.circular(24.h);
  static BorderRadius get roundedBorder32 => BorderRadius.circular(32.h);
  static BorderRadius get roundedBorder44 => BorderRadius.circular(44.h);
  static BorderRadius get roundedBorder48 => BorderRadius.circular(48.h);
  static BorderRadius get roundedBorder6 => BorderRadius.circular(6.h);
}
