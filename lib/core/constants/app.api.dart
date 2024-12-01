part of 'constants.dart';

class AppAPI {
  AppAPI._();
  // static const String domain = 'http://172.20.10.4:1111/api/'; // hostpost
  // static const String domain = 'http://10.100.3.149:1111/api/'; // CMCC
  static const String domain = 'http://192.168.0.101:1111/api/'; // home

  /// Auth
  static const String baseAuth = '${domain}auth';
  static const String loginUrl = '${baseAuth}/login';
  static const String revokeToken = '${baseAuth}/revoke-token';
  static const String register = '${baseAuth}/register';
  static const String resetPassword = '${baseAuth}/reset-password';
  static const String changePassword = '${baseAuth}/change-password';
  static const String resendOtp = '${baseAuth}/resend-otp';
  static const String loginWithOtp = '${baseAuth}/login-with-otp';
  static const String refreshToken = '${baseAuth}/refresh-token';
  static const String verifyEmail = '${baseAuth}/verify-email';
  static const String verifyCode = '${baseAuth}/verify-code';
  static const String changeAvatar = '${baseAuth}/change-avatar';
  static const String updatePassword = '${baseAuth}/update-password';
  static const String updateProfile = '${baseAuth}/update-profile';
  static const String deleteAccount = '${baseAuth}/delete-account';
  static const String forgotPassword = '${baseAuth}/forgot-password';

  /// User
  static const String baseUser = '${domain}user';
  static const String userCurrent = '${baseUser}/current';
  static const String userFriend = '${baseUser}/friend';

  /// Upload Realtime
  static const String uploadRealtime = '${domain}upload-realtime';
  static const String getRealtime = '${domain}upload/realtime';
  static const String editRealtime = '${domain}upload/realtime';
  static const String deleteRealtime = '${domain}upload/realtime';

  /// Group
  static const String baseGroup = '${domain}group';

  /// Expense
  static const String baseExpense = '${domain}expense';

  /// Plan
  static const String basePlan = '${domain}plan';
  static const String planGroup = '${basePlan}/group';
  static const String planSetComplete = '${basePlan}/completed';
  static const String planLocation = '${basePlan}/location';
  static const String planPost = '${basePlan}/post';

  /// Member
  static const String getMember = '${domain}member';
  static const String createMember = '${domain}member';
  static const String editMember = '${domain}member';
  static const String deleteMember = '${domain}member';
}
