import 'package:kiwis_flutter/core/base/base.api.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/models/api.response.dart';

class ExpenseRequest {
  final BaseAPI _baseAPI = BaseAPI();

  Future<ApiResponse> getExpenseRequest() async {
    var response = await _baseAPI.fetchData(
      AppAPI.baseExpense,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> createExpenseRequest({
    required String name,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.baseExpense,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> editExpenseRequest({
    required String id,
    required String name,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.baseExpense,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> deleteExpenseRequest({
    required String id,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.baseExpense,
    );
    return ApiResponse.fromResponse(response.data);
  }
}
