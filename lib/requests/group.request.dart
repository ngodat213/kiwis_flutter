import 'dart:io';
import 'dart:typed_data';

import 'package:kiwis_flutter/core/base/base.api.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/models/api.response.dart';
import 'package:dio/dio.dart';

class GroupRequest {
  final BaseAPI _baseAPI = BaseAPI();

  Future<ApiResponse> getGroupRequest() async {
    var response = await _baseAPI.fetchData(
      AppAPI.baseGroup,
      includeHeaders: true,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> createGroupRequest({
    required String name,
    required List<String> members,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.baseGroup,
      includeHeaders: true,
      method: ApiMethod.POST,
      body: {
        "name": name,
        "members": members,
      },
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> editGroupRequest({
    required String groupId,
    required String? name,
    required Uint8List? file,
  }) async {
    Response response;
    if (file != null) {
      response = await _baseAPI.fileUpload(
        AppAPI.baseGroup + "/$groupId",
        includeHeaders: true,
        method: ApiMethod.PUT,
        body: {
          "name": name,
        },
        file: file,
      );
    } else {
      response = await _baseAPI.fetchData(
        AppAPI.baseGroup + "/$groupId",
        method: ApiMethod.PUT,
        includeHeaders: true,
        body: {"name": name},
      );
    }
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

  Future<ApiResponse> uploadAvatarRequest({
    required String id,
    required File file,
  }) async {
    var response = await _baseAPI.fetchData(AppAPI.baseGroup);
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> leaveGroupRequest({
    required String groupId,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.baseGroup,
      method: ApiMethod.DELETE,
      body: {"groupId": groupId},
    );
    return ApiResponse.fromResponse(response.data);
  }
}
