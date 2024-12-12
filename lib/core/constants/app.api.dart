part of 'constants.dart';

class AppAPI {
  AppAPI._();
  // static const String domain = 'http://172.20.10.4:1111/api/'; // hostpost
  // static const String domain = 'http://10.100.3.149:1111/api/'; // CMCC
  static const String domainApi = 'http://192.168.0.103:1111/api/'; // home
  static const String domainSocket = 'http://192.168.0.103:2222'; // home

  /// Socket
  static const String socketRegister = 'register';
  static const String socketGroupMessage = 'send_group_message';
  static const String socketReceiveGroupMessage = 'receive_group_message';
  static const String socketDisconnect = 'disconnect';
  static const String socketConnect = 'connect';
  static const String socketSendComment = 'send_comment';
  static const String socketReceivePost = 'receive_post';
  static const String socketSendPost = 'send_post';

  /// Auth
  static const String baseAuth = '${domainApi}auth';
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
  static const String updatePassword = '${baseAuth}/update-password';
  static const String updateProfile = '${baseAuth}/update-profile';
  static const String deleteAccount = '${baseAuth}/delete-account';
  static const String forgotPassword = '${baseAuth}/forgot-password';

  /// User
  static const String baseUser = '${domainApi}user';
  static const String userCurrent = '${baseUser}/current';
  static const String userFriend = '${baseUser}/friend';
  static const String updateDisplayName = '${baseUser}/update-user';
  static const String userChangeAvatar = '${baseUser}/change-avatar';

  /// Upload Realtime
  static const String uploadRealtime = '${domainApi}upload-realtime';
  static const String getRealtime = '${domainApi}upload/realtime';
  static const String editRealtime = '${domainApi}upload/realtime';
  static const String deleteRealtime = '${domainApi}upload/realtime';

  /// Group
  static const String baseGroup = '${domainApi}group';

  /// Expense
  static const String baseExpense = '${domainApi}expense';

  /// Plan
  static const String basePlan = '${domainApi}plan';
  static const String planGroup = '${basePlan}/group';
  static const String planSetComplete = '${basePlan}/completed';
  static const String planLocation = '${basePlan}/location';
  static const String planPost = '${basePlan}/post';
  static const String planAllLocation = '${basePlan}/plan-location';

  /// Member
  static const String getMember = '${domainApi}member';
  static const String createMember = '${domainApi}member';
  static const String editMember = '${domainApi}member';
  static const String deleteMember = '${domainApi}member';

  /// Message
  static const String message = '${domainApi}message';
}
