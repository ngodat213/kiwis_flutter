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

  Future<ApiResponse> addFriendRequest(String friendId) async {
    var response = await _baseAPI.fetchData(
      AppAPI.userFriend,
      method: ApiMethod.POST,
      includeHeaders: true,
      body: {
        "friendId": friendId,
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
}
