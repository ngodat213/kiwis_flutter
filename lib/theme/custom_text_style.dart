import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/app_export.dart';

extension on TextStyle {
  TextStyle get googleSans => copyWith(fontFamily: 'GoogleSans');
  TextStyle get lemonMilk => copyWith(fontFamily: 'LemonMilk');
  TextStyle get oleoScript => copyWith(fontFamily: 'Oleo Script Swash Caps');
  TextStyle get googleSansMedium => copyWith(fontFamily: 'Google Sans Medium');
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions to enhance the existing
class CustomTextStyles {
  // Body text style
  static TextStyle get bodyMediumGoogleSansMediumOnPrimary =>
      theme.textTheme.bodyMedium!.googleSansMedium.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.5),
      );

  static TextStyle get bodySmall10GoogleSansRegularOnPrimary =>
      theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
      );

  static TextStyle get bodySmall8 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 8.fSize,
      );

  static TextStyle get bodySmallAmber600 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.amber600,
      );

  static TextStyle get bodySmallOnPrimary =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );

  static TextStyle get bodySmallOnPrimary10 =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );

  static TextStyle get bodySmall0nPrimary10 =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontSize: 10.fSize,
      );
// Display text style
  static TextStyle get displayMedium48 =>
      theme.textTheme.displayMedium!.copyWith(
        fontSize: 48.fSize,
      );
// Label text style
  static TextStyle get labelLargeGoogleSansMedium =>
      theme.textTheme.labelLarge!.googleSansMedium.copyWith(
        fontWeight: FontWeight.w500,
      );

  static TextStyle get labelLargeGoogleSansMediumOnPrimary =>
      theme.textTheme.labelLarge!.googleSansMedium.copyWith(
        color: appTheme.gray5002,
      );

  static TextStyle get labelLargeGreen600 =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.green600,
      );

  static TextStyle get labelLargeOnPrimary =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.5),
      );

  // Title text style
  static TextStyle get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
      );

  static TextStyle get titleMedium19 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 19.fSize,
      );

  static TextStyle get titleMediumGray5002 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray5002,
      );

  static TextStyle get titleMediumOnPrimary =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.3),
      );

  static TextStyle get titleSmallGoogleSansMedium =>
      theme.textTheme.titleSmall!.googleSansMedium.copyWith(
        fontWeight: FontWeight.w500,
      );

  static TextStyle get titleSmallGoogleSansMediumMedium =>
      theme.textTheme.titleSmall!.googleSansMedium.copyWith(
        fontWeight: FontWeight.w500,
      );

  static TextStyle get titleSmallGoogleSansMediumOnPrimary =>
      theme.textTheme.titleSmall!.googleSansMedium.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.5),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get titleSmallGreen300 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.green300,
      );
}
