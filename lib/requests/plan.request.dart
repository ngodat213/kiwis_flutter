import 'package:kiwis_flutter/core/base/base.api.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/models/api.response.dart';

class PlanRequest {
  final BaseAPI _baseAPI = BaseAPI();

  Future<ApiResponse> getPlanRequest() async {
    var response = await _baseAPI.fetchData(
      AppAPI.basePlan,
      includeHeaders: true,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> createPlan(
    String title,
    String description,
    String budget,
    DateTime startDay,
    DateTime endDay,
  ) async {
    var response = await _baseAPI.fetchData(
      AppAPI.basePlan,
      method: ApiMethod.POST,
      includeHeaders: true,
      body: {
        "name": title,
        "description": description,
        "totalCost": int.parse(budget),
        "startDate": startDay.toIso8601String(),
        "endDate": endDay.toIso8601String(),
      },
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> findAllPlan() async {
    var response = await _baseAPI.fetchData(
      AppAPI.basePlan,
      includeHeaders: true,
    );

    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> findPlanById() async {
    var reponse = await _baseAPI.fetchData(
      AppAPI.basePlan,
      includeHeaders: true,
    );

    return ApiResponse.fromResponse(reponse.data);
  }

  Future<ApiResponse> updatePlanById() async {
    var reponse = await _baseAPI.fetchData(
      AppAPI.basePlan,
      includeHeaders: true,
    );

    return ApiResponse.fromResponse(reponse.data);
  }

  Future<ApiResponse> deletePlanById() async {
    var reponse = await _baseAPI.fetchData(
      AppAPI.basePlan,
      includeHeaders: true,
    );

    return ApiResponse.fromResponse(reponse.data);
  }

  Future<ApiResponse> setPlanCompleted() async {
    var reponse = await _baseAPI.fetchData(
      AppAPI.basePlan,
      includeHeaders: true,
    );

    return ApiResponse.fromResponse(reponse.data);
  }

  Future<ApiResponse> addPlanLocation() async {
    var reponse = await _baseAPI.fetchData(
      AppAPI.planLocation,
      includeHeaders: true,
    );

    return ApiResponse.fromResponse(reponse.data);
  }

  Future<ApiResponse> updatePlanLocation() async {
    var reponse = await _baseAPI.fetchData(
      AppAPI.planLocation,
      includeHeaders: true,
    );

    return ApiResponse.fromResponse(reponse.data);
  }

  Future<ApiResponse> deletei3PlanLocation() async {
    var reponse = await _baseAPI.fetchData(
      AppAPI.planLocation,
      includeHeaders: true,
    );

    return ApiResponse.fromResponse(reponse.data);
  }

  Future<ApiResponse> deleteRealtimeImageFromPlan() async {
    var reponse = await _baseAPI.fetchData(
      AppAPI.basePlan,
      includeHeaders: true,
    );

    return ApiResponse.fromResponse(reponse.data);
  }
}
