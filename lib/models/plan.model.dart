import 'package:kiwis_flutter/models/cloudinary_image.model.dart';
import 'package:kiwis_flutter/models/cost.model.dart';
import 'package:kiwis_flutter/models/friend_data.model.dart';
import 'package:kiwis_flutter/models/group.model.dart';
import 'package:kiwis_flutter/models/task.model.dart';

class PlanModel {
  String? planId;
  String? createdById;
  String? groupId;
  String? name;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  int? totalCost;
  bool? isCompleted;
  String? thumbnailId;
  bool? isStart;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  FriendDataModel? createdBy;
  GroupModel? group;
  CloudinaryImageModel? thumbnail;
  List<Null>? realtimeImages;
  List<CostModel>? planCosts;
  List<TaskModel>? tasks;

  PlanModel(
      {this.planId,
      this.createdById,
      this.groupId,
      this.name,
      this.startDate,
      this.endDate,
      this.totalCost,
      this.isCompleted,
      this.thumbnailId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.createdBy,
      this.group,
      this.thumbnail,
      this.realtimeImages,
      this.planCosts});

  PlanModel.fromJson(Map<String, dynamic> json) {
    planId = json['planId'] ?? null;
    createdById = json['createdById'] == null ? null : json['createdById'];
    groupId = json['groupId'] == null ? null : json['groupId'];
    name = json['name'] == null ? null : json['name'];
    startDate = DateTime.parse(json['startDate']) == null
        ? null
        : DateTime.parse(json['startDate']);
    endDate = DateTime.parse(json['endDate']) == null
        ? null
        : DateTime.parse(json['endDate']);
    totalCost = json['totalCost'] == null ? null : json['totalCost'];
    isCompleted = json['isCompleted'] == null ? null : json['isCompleted'];
    thumbnailId = json['thumbnailId'] == null ? null : json['thumbnailId'];
    createdAt =
        json['createdAt'] == null ? null : DateTime.parse(json['createdAt']);
    updatedAt =
        json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']);
    deletedAt =
        json['deletedAt'] == null ? null : DateTime.parse(json['deletedAt']);
    createdBy = json['createdBy'] != null
        ? FriendDataModel.fromJson(json['createdBy'])
        : null;
    group = json['group'] != null ? GroupModel.fromJson(json['group']) : null;
    thumbnail = json['thumbnail'] != null
        ? CloudinaryImageModel.fromJson(json['thumbnail'])
        : null;
    description = json['description'] == null ? null : json['description'];
    if (json['tasks'] != null) {
      tasks = <TaskModel>[];
      json['tasks'].forEach((v) {
        tasks!.add(TaskModel.fromJson(v));
      });
    }
    isStart = json['isStart'] == null ? null : json['isStart'];
    // if (json['realtimeImages'] != null) {
    //   realtimeImages = <Null>[];
    //   json['realtimeImages'].forEach((v) {
    //     realtimeImages!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['planCosts'] != null) {
      planCosts = <CostModel>[];
      json['planCosts'].forEach((v) {
        planCosts!.add(CostModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['planId'] = this.planId;
    data['createdById'] = this.createdById;
    data['groupId'] = this.groupId;
    data['name'] = this.name;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['totalCost'] = this.totalCost;
    data['isCompleted'] = this.isCompleted;
    data['thumbnailId'] = this.thumbnailId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    data['group'] = this.group?.toJson();
    data['thumbnail'] = this.thumbnail?.toJson();
    data['description'] = this.description;
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    data['isStart'] = this.isStart;
    // if (this.realtimeImages != null) {
    //   data['realtimeImages'] =
    //       this.realtimeImages!.map((v) => v.toJson()).toList();
    // }
    if (this.planCosts != null) {
      data['planCosts'] = this.planCosts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
