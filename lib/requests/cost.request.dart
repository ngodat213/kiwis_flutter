import 'package:kiwis_flutter/core/base/base.api.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/models/api.response.dart';

class CostRequest {
  final BaseAPI _baseAPI = BaseAPI();

  Future<ApiResponse> createExpense({
    required String amount,
    required String payerId,
    required String planId,
    required String note,
    required String sharedWith,
    required List<String> individualShares,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.baseExpense,
      includeHeaders: true,
      method: ApiMethod.POST,
      body: {
        "amount": amount,
        "payerId": payerId,
        "planId": planId,
        "note": note,
        "sharedWith": sharedWith,
        "individualShares": individualShares,
      },
    );
    return ApiResponse.fromResponse(response.data);
  }
}
