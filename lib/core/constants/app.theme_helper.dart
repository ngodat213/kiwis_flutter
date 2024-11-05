import 'package:flutter/material.dart';
import 'app_export.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // The current app theme
  var _appTheme = PrefUtils().getThemeData();

// A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    PrefUtils().setThemeData(_newTheme);
    Get.forceAppUpdate();
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: appTheme.gray900,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.onPrimary.withOpacity(0.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return Colors.transparent;
        }),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 24,
        space: 24,
        color: colorScheme.onPrimary.withOpacity(1),
      ),
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyMedium: TextStyle(
          color: appTheme.gray900,
          fontSize: 14.fSize,
          fontFamily: 'Lemon',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: colorScheme.onPrimary.withOpacity(0.5),
          fontSize: 12.fSize,
          fontFamily: 'Google Sans',
          fontWeight: FontWeight.w400,
        ),
        displayMedium: TextStyle(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 40.fSize,
          fontFamily: 'Google Sans',
          fontWeight: FontWeight.w700,
        ),
        headlineLarge: TextStyle(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 32.fSize,
          fontFamily: 'Google Sans',
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: TextStyle(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 29.fSize,
          fontFamily: 'Oleo Script Swash Caps',
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: TextStyle(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 24.fSize,
          fontFamily: 'Google Sans',
          fontWeight: FontWeight.w700,
        ),
        labelLarge: TextStyle(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 12.fSize,
          fontFamily: 'Google Sans',
          fontWeight: FontWeight.w700,
        ),
        labelMedium: TextStyle(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 10.fSize,
          fontFamily: 'Google Sans Medium',
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 8.fSize,
          fontFamily: 'Google Sans',
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 20.fSize,
          fontFamily: 'Google Sans',
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 16.fSize,
          fontFamily: 'Google Sans',
          fontWeight: FontWeight.w700,
        ),
        titleSmall: TextStyle(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 14.fSize,
          fontFamily: 'Google Sans',
          fontWeight: FontWeight.w700,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFF1E40F4),
    primaryContainer: Color(0XFFAAF6C0),
    secondaryContainer: Color(0XFF2E42A4),
    errorContainer: Color(0XFF264AE6),
    onError: Color(0XFFEB001B),
    onPrimary: Color(0X19FFFFFF),
    onPrimaryContainer: Color(0XFF2D2824),
  );
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  Color get primary => Color(0xff14151C);
  // Amber
  Color get amber400 => Color(0XFFFBCD17);
  Color get amber600 => Color(0XFFFFB700);
  Color get amberA400 => Color(0XFFFECA00);
// Black
  Color get black900 => Color(0XFF000000);
// Blue
  Color get blue200 => Color(0XFFA1C1FF);
  Color get blue300 => Color(0XFF63B3E1);
  Color get blue30001 => Color(0XFF5EAEFF);
  Color get blue400 => Color(0XFF559BFF);
  Color get blue500 => Color(0XFF3195F9);
  Color get blue600 => Color(0XFF3F92CF);
  Color get blueA200 => Color(0XFF467EFF);
  Color get blueA40019 => Color(0X193772FF);
// BlueGray
  Color get blueGray100 => Color(0XFFD9D9D9);
  Color get blueGray200 => Color(0XFFB1B5C3);
// Cyan
  Color get cyan500 => Color(0XFF08CCCC);
  Color get cyanA200 => Color(0XFF2EE6FF);
// Gray
  Color get gray50 => Color(0XFFF7FCFF);
  Color get gray5001 => Color(0XFFF7FBFF);
  Color get gray5002 => Color(0XFFFCFCFD);
  Color get gray800 => Color(0XFF353945);
  Color get gray80001 => Color(0XFF47392D);
  Color get gray900 => Color(0XFF141416);
  Color get gray90001 => Color(0XFF2D1A34);
  Color get gray90002 => Color(0XFF1D1D1D);
  Color get gray90003 => Color(0XFF23262F);
  Color get gray90033 => Color(0X33121213);
// Green
  Color get green300 => Color(0XFF7BFF79);
  Color get green600 => Color(0XFF23B24B);
  Color get green60001 => Color(0XFF24B24C);
// Indigo
  Color get indigo500 => Color(0XFF2C47D3);
  Color get indigo900 => Color(0XFF001270);
  Color get indigoA200 => Color(0XFF4377FF);
  Color get indigoA400 => Color(0XFF3B67FF);
  Color get indigoA40001 => Color(0XFF345AFF);
  Color get indigoA700 => Color(0XFF2744DD);
  Color get indigoA70001 => Color(0XFF2E50FF);
// LightBlue
  Color get lightBlue900 => Color(0XFF00579F);
// Orange
  Color get orangeA700 => Color(0XFFFF5F00);
// Pink
  Color get pinkA100 => Color(0XFFFF60D2);
// Red
  Color get red700 => Color(0XFFE31D1C);
  Color get red70001 => Color(0XFFE11C1B);
// Teal
  Color get teal100 => Color(0XFFC1DFE3);
  Color get teal800 => Color(0XFF086660);
// Yellow
  Color get yellow800 => Color(0XFFFAA61A);
  Color get yellow80001 => Color(0XFFF79E1B);
}
