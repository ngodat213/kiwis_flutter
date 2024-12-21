import 'package:kiwis_flutter/models/plan_location.model.dart';

class TaskModel {
  String? taskId;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  String? status;
  int? totalCost;
  String? planId;
  String? planLocationId;
  PlanLocationModel? planLocation;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;

  TaskModel(
      {this.taskId,
      this.title,
      this.description,
      this.startDate,
      this.endDate,
      this.status,
      this.totalCost,
      this.planId,
      this.planLocationId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  TaskModel.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    title = json['title'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    status = json['status'];
    totalCost = json['totalCost'];
    planId = json['planId'];
    planLocationId = json['planLocationId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    planLocation = json['planLocation'] != null
        ? PlanLocationModel.fromJson(json['planLocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskId'] = this.taskId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['status'] = this.status;
    data['totalCost'] = this.totalCost;
    data['planId'] = this.planId;
    data['planLocationId'] = this.planLocationId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.planLocation != null) {
      data['planLocation'] = this.planLocation!.toJson();
    }
    return data;
  }
}
