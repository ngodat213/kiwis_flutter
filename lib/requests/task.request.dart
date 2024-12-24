import 'package:kiwis_flutter/core/base/base.api.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/models/api.response.dart';
import 'package:kiwis_flutter/models/task.model.dart';

class TaskRequest {
  final BaseAPI _baseAPI = BaseAPI();

  Future<ApiResponse> createTask({
    required String planId,
    required String title,
    required String description,
    required String budget,
    required DateTime startDate,
    required DateTime endDate,
    required int estimatedCost,
    required int estimatedTime,
    String? locationName,
    double? latitude,
    double? longitude,
    String? address,
  }) async {
    var response = await _baseAPI.fetchData(
      AppAPI.baseTask,
      includeHeaders: true,
      method: ApiMethod.POST,
      body: {
        "title": title,
        "description": description,
        "budget": int.parse(budget),
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "planId": planId,
        "status": "TODO",
        "planLocation": {
          "name": locationName,
          "latitude": latitude,
          "longitude": longitude,
          "address": address,
          "estimatedCost": estimatedCost,
          "estimatedTime": estimatedTime,
        },
      },
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> updateTaskIsDone({required String taskId}) async {
    var response = await _baseAPI.fetchData(
      AppAPI.baseTask + '/$taskId',
      includeHeaders: true,
      method: ApiMethod.PUT,
      body: {
        "status": "COMPLETED",
      },
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> deleteTask({required String taskId}) async {
    var response = await _baseAPI.fetchData(
      AppAPI.baseTask + '/$taskId',
      includeHeaders: true,
      method: ApiMethod.DELETE,
    );
    return ApiResponse.fromResponse(response.data);
  }
}
