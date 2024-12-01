import 'package:kiwis_flutter/core/base/base.api.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/models/api.response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiwis_flutter/services/services.dart';

class AuthRequest {
  final BaseAPI _baseAPI = BaseAPI();

  Future<ApiResponse> loginRequest({
    required String email,
    required String password,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.loginUrl,
      method: ApiMethod.POST,
      body: {
        "email": email,
        "password": password,
      },
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Logout
  Future<ApiResponse> revokeFirebaseTokenRequest() async {
    String firebaseToken = await AuthServices.getAuthFirebaseToken();
    var response = await _baseAPI.fetchData(
      AppAPI.revokeToken,
      includeHeaders: true,
      headers: {
        "Authorization": "Bearer $firebaseToken",
      },
      method: ApiMethod.POST,
    );
    return ApiResponse.fromResponse(response.data);
  }

  // Register
  Future<ApiResponse> registerRequest(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    var reponse = await _baseAPI.fetchData(
      AppAPI.register,
      method: ApiMethod.POST,
      body: {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
      },
    );

    return ApiResponse.fromResponse(reponse.data);
  }

  Future<ApiResponse> refreshTokenRequest() async {
    var response = await _baseAPI.fetchData(
      AppAPI.refreshToken,
      includeHeaders: true,
      method: ApiMethod.POST,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> verifyEmailRequest({
    required String email,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.verifyEmail,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> verifyCodeRequest({
    required String email,
    required String code,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.verifyCode,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> changeAvatarRequest({
    required String email,
    required XFile photo,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.changeAvatar,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> updatePasswordRequest({
    required String oldPassword,
    required String newPassword,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.updatePassword,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> updateProfileRequest({
    required String username,
    required String email,
    required String phone,
    required String countryCode,
    required XFile photo,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.updateProfile,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> deleteAccountRequest() async {
    var response = await _baseAPI.fetchData(
      AppAPI.deleteAccount,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> forgotPasswordRequest({
    required String email,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.forgotPassword,
      method: ApiMethod.POST,
      body: {"email": email},
    );
    return ApiResponse.fromResponse(response.data);
  }
}
