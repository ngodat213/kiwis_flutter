import 'dart:typed_data';

import 'package:kiwis_flutter/core/base/base.api.dart';
import 'package:kiwis_flutter/core/constants/constants.dart';
import 'package:kiwis_flutter/models/api.response.dart';
import 'package:kiwis_flutter/models/plan.model.dart';
import 'package:kiwis_flutter/models/plan_location.model.dart';

class PlanRequest {
  final BaseAPI _baseAPI = BaseAPI();

  Future<ApiResponse> getPlanRequest() async {
    var response = await _baseAPI.fetchData(
      AppAPI.basePlan,
      includeHeaders: true,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> getPlanByGroupId(String groupId) async {
    var response = await _baseAPI.fetchData(
      AppAPI.planGroup + "/$groupId",
      includeHeaders: true,
    );
    return ApiResponse.fromResponse(response.data);
  }

  Future<ApiResponse> createPlan({
    required String title,
    required String description,
    required String budget,
    required DateTime startDay,
    required DateTime endDay,
    Uint8List? image,
    String? groupId,
  }) async {
    var response = image != null
        ? await _baseAPI.fileUpload(
            AppAPI.basePlan,
            method: ApiMethod.POST,
            includeHeaders: true,
            body: {
              "name": title,
              "description": description,
              "totalCost": int.parse(budget),
              "startDate": startDay.toIso8601String(),
              "endDate": endDay.toIso8601String(),
              "groupId": groupId,
            },
            file: image,
          )
        : await _baseAPI.fetchData(
            AppAPI.basePlan,
            method: ApiMethod.POST,
            includeHeaders: true,
            body: {
              "name": title,
              "description": description,
              "totalCost": int.parse(budget),
              "startDate": startDay.toIso8601String(),
              "endDate": endDay.toIso8601String(),
              "groupId": groupId,
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

  Future<ApiResponse> findPlanById(String planId) async {
    var reponse = await _baseAPI.fetchData(
      AppAPI.basePlan + "/$planId",
      includeHeaders: true,
      method: ApiMethod.GET,
    );

    return ApiResponse.fromResponse(reponse.data);
  }

  Future<ApiResponse> updatePlanById(String planId, PlanModel plan) async {
    var reponse = await _baseAPI.fetchData(
      AppAPI.basePlan + "/$planId",
      includeHeaders: true,
      method: ApiMethod.PUT,
      body: {
        "name": plan.name,
        "totalCost": plan.totalCost.toString(),
        "startDate": plan.startDate?.toIso8601String(),
        "endDate": plan.endDate?.toIso8601String(),
      },
    );

    return ApiResponse.fromResponse(reponse.data);
  }

  Future<ApiResponse> updateAllPlanLocation(
    String planId,
    List<PlanLocationModel> locations,
  ) async {
    var reponse = await _baseAPI.fetchData(
      AppAPI.planAllLocation + "/$planId",
      includeHeaders: true,
      method: ApiMethod.PUT,
      body: locations.map((e) => e.toJson()).toList(),
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

  Future<ApiResponse> addPlanLocation(
    String planId,
    PlanLocationModel location,
  ) async {
    var reponse = await _baseAPI.fetchData(
      AppAPI.planLocation + "/$planId",
      includeHeaders: true,
      method: ApiMethod.POST,
      body: location.toJson(),
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
