import 'package:kiwis_flutter/core/base/base.api.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/models/api.response.dart';

class GroupRequest {
  final BaseAPI _baseAPI = BaseAPI();

  Future<ApiResponse> getGroupRequest() async {
    var response = await _baseAPI.fetchData(
      AppAPI.baseGroup,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> createGroupRequest({
    required String name,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.baseGroup,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> editGroupRequest({
    required String id,
    required String name,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.baseGroup,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> deleteGroupRequest({
    required String id,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.baseGroup,
    );
    return ApiResponse.fromResponse(response.data);
  }
}
