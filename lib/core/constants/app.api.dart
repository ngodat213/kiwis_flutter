part of 'constants.dart';

class AppAPI {
  AppAPI._();
  static const String domain = 'http://192.168.0.108:1111/api/';
  static const String loginUrl = '${domain}auth/login';
  static const String logout = '${domain}auth/logout';

  /// User
  static const String currentUser = '${domain}user/current';
}
