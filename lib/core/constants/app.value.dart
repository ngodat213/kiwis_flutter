import 'app_export.dart';

abstract class AppValues {
  AppValues._();

  /// Time
  static const int defaultDebounceTimeInMilliSeconds = 1000;
  static const String defaultAvatar = ImageConstant.imgAvatar;

  /// SPLASH screen delay
  static const int splashScreenDelaySeconds = 3;

  /// Logger
  static const int loggerLineLength = 120;
  static const int loggerErrorMethodCount = 8;
  static const int loggerMethodCount = 2;

  /// Page
  static const int defaultPageNumber = 1;
}
