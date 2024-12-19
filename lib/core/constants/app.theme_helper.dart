import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';

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
      scaffoldBackgroundColor: colorScheme.onPrimaryContainer.withOpacity(1),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.black9000a,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.h),
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
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.onPrimaryContainer,
      ),
      dividerTheme: DividerThemeData(
        thickness: 24,
        space: 24,
        color: colorScheme.onErrorContainer,
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
        bodySmall: TextStyle(
          color: appTheme.gray800,
          fontSize: 12.fSize,
          fontFamily: 'Google Sans',
          fontWeight: FontWeight.w400,
        ),
        displayMedium: TextStyle(
          color: colorScheme.onErrorContainer,
          fontSize: 40.fSize,
          fontFamily: 'Google Sans',
          fontWeight: FontWeight.w700,
        ),
        headlineLarge: TextStyle(
          color: colorScheme.onErrorContainer,
          fontSize: 32.fSize,
          fontFamily: 'Google Sans',
          fontWeight: FontWeight.w700,
        ),
        labelLarge: TextStyle(
          color: colorScheme.onErrorContainer,
          fontSize: 12.fSize,
          fontFamily: 'Google Sans',
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          color: colorScheme.onErrorContainer,
          fontSize: 20.fSize,
          fontFamily: 'Google Sans',
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: colorScheme.onErrorContainer,
          fontSize: 16.fSize,
          fontFamily: 'Google Sans',
          fontWeight: FontWeight.w700,
        ),
        titleSmall: TextStyle(
          color: colorScheme.onErrorContainer,
          fontSize: 14.fSize,
          fontFamily: 'Google Sans',
          fontWeight: FontWeight.w700,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFFFFB700),
    primaryContainer: Color(0XFFEB001B),
    secondaryContainer: Color(0XFFB1B5C3),
    errorContainer: Color(0XFF3772FF),
    onError: Color(0XFFFAA61A),
    onErrorContainer: Color(0XFF141416),
    onPrimary: Color(0XFF1D1D1D),
    onPrimaryContainer: Color(0X19FFFFFF),
  );
}

/// Class containing custom colors for a lightCode theme.
/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  // Amber
  Color get amber400 => Color(0XFFFBCD17);
  Color get amberA400 => Color(0XFFFECA00);
// Black
  Color get black9000a => Color(0X0A000000);
  Color get black => Colors.black;
// Blue
  Color get blue300 => Color(0XFF63B3E1);
  Color get blue500 => Color(0XFF3195F9);
// BlueGray
  Color get blueGray400 => Color(0XFF777E90);
// Gray
  Color get gray100 => Color(0XFFF4F5F6);
  Color get gray200 => Color(0XFFE6E8EC);
  Color get gray50 => Color(0XFFF7FCFF);
  Color get gray5001 => Color(0XFFF7FBFF);
  Color get gray5002 => Color(0XFFFCFCFD);
  Color get gray800 => Color(0XFF353945);
// Green
  Color get green50 => Color(0XFFD9FDE4);
  Color get green600 => Color(0XFF23B24B);
// Indigo
  Color get indigo700 => Color(0XFF2E42A4);
  Color get indigoA700 => Color(0XFF1E40F4);
// LightBlue
  Color get lightBlue900 => Color(0XFF00579F);
// Orange
  Color get orangeA700 => Color(0XFFFF5F00);
// Red
  Color get red700 => Color(0XFFE31D1C);
  Color get red70001 => Color(0XFFE11C1B);
// Yellow
  Color get yellow800 => Color(0XFFF79E1B);
}
