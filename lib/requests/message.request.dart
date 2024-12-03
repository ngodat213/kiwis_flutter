import 'package:kiwis_flutter/core/base/base.api.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/models/api.response.dart';

class MessageRequest {
  final BaseAPI _baseAPI = BaseAPI();

  Future<ApiResponse> getAllMessages() async {
    var response = await _baseAPI.fetchData(
      AppAPI.message,
      method: ApiMethod.GET,
      includeHeaders: true,
    );
    return ApiResponse.fromResponse(response.data);
  }
}
