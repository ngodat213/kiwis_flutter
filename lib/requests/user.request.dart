import 'dart:typed_data';

import 'package:kiwis_flutter/core/base/base.api.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/models/api.response.dart';

class UserRequest {
  final BaseAPI _baseAPI = BaseAPI();

  Future<ApiResponse> getCurrentUser() async {
    var response = await _baseAPI.fetchData(
      AppAPI.userCurrent,
      method: ApiMethod.GET,
      includeHeaders: true,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> addFriendRequest(String phoneNumber) async {
    var response = await _baseAPI.fetchData(
      AppAPI.userFriend,
      method: ApiMethod.POST,
      includeHeaders: true,
      body: {
        "phoneNumber": phoneNumber,
      },
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> getAllFriendsRequest() async {
    var response = await _baseAPI.fetchData(
      AppAPI.userFriend,
      method: ApiMethod.GET,
      includeHeaders: true,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> getAllFriendPending() async {
    var response = await _baseAPI.fetchData(
      AppAPI.userFriendPending,
      method: ApiMethod.GET,
      includeHeaders: true,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> updateDisplayName(
    String firstName,
    String lastName,
  ) async {
    var response = await _baseAPI.fetchData(
      AppAPI.updateDisplayName,
      method: ApiMethod.PUT,
      includeHeaders: true,
      body: {
        "firstName": firstName,
        "lastName": lastName,
      },
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> updatePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    var response = await _baseAPI.fetchData(
      AppAPI.baseUser,
      method: ApiMethod.PUT,
      includeHeaders: true,
      body: {
        "currentPassword": currentPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      },
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> changeAvatarRequest(
    Uint8List photo,
  ) async {
    var response = await _baseAPI.fileUpload(
      AppAPI.userChangeAvatar,
      includeHeaders: true,
      method: ApiMethod.POST,
      // body: {
      //   "": '',
      // },
      file: photo,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> updateFcmToken(String fcmToken) async {
    var response = await _baseAPI.fetchData(
      AppAPI.userUpdateFcmToken,
      method: ApiMethod.PUT,
      includeHeaders: true,
      body: {
        "fcmToken": fcmToken,
      },
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> acceptFriendRequest(String friendshipId) async {
    var response = await _baseAPI.fetchData(
      AppAPI.userFriendAccept,
      method: ApiMethod.POST,
      includeHeaders: true,
      body: {
        "friendshipId": friendshipId,
      },
    );
    return ApiResponse.fromResponse(response.data);
  }
}
