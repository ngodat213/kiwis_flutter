import 'package:image_picker/image_picker.dart';
import 'package:kiwis_flutter/core/base/base.api.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/models/api.response.dart';

class UploadRealtimeRequest {
  final BaseAPI _baseAPI = BaseAPI();

  Future<ApiResponse> uploadRealtimeRequest({
    required XFile file,
    required String caption,
  }) async {
    var response = await _baseAPI.fileUpload(
      AppAPI.uploadRealtime,
      method: ApiMethod.POST,
      includeHeaders: true,
      file: await file.readAsBytes(),
      body: {
        "caption": caption,
      },
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> getRealtimeRequest() async {
    var response = await _baseAPI.fetchData(
      AppAPI.uploadRealtime,
      includeHeaders: true,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> editRealtimeRequest({
    required String id,
    required String title,
    required String description,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.editRealtime,
      includeHeaders: true,
      method: ApiMethod.PUT,
      body: {
        "title": title,
        "description": description,
      },
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> deleteRealtimeRequest({
    required String id,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.deleteRealtime,
      includeHeaders: true,
      method: ApiMethod.DELETE,
    );
    return ApiResponse.fromResponse(response.data);
  }
}
