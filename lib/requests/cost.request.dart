import 'package:kiwis_flutter/core/base/base.api.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/models/api.response.dart';

class CostRequest {
  final BaseAPI _baseAPI = BaseAPI();

  Future<ApiResponse> createExpense({
    required String amount,
    required String title,
    required String payerId,
    required String planId,
    required String note,
    required String sharedWith,
    required List<Map<String, dynamic>> individualShares,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.planCostSharing + "/$planId",
      includeHeaders: true,
      method: ApiMethod.POST,
      body: {
        "amount": amount,
        "title": title,
        "payerId": payerId,
        "note": note,
        "sharedWith": sharedWith,
        "individualShares": individualShares,
      },
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> getCostSharing(String planId) async {
    var response = await _baseAPI.fetchData(
      AppAPI.planCostSharing + "/$planId",
      includeHeaders: true,
      method: ApiMethod.GET,
    );
    return ApiResponse.fromResponse(response.data);
  }
}
