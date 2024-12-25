import 'package:kiwis_flutter/models/friend_data.model.dart';
import 'package:kiwis_flutter/models/shared_user.model.dart';

class CostModel {
  String? costShareId;
  String? title;
  String? planId;
  String? payerId;
  String? note;
  int? amount;
  String? sharedWith;
  FriendDataModel? payer;
  List<SharedUsers>? sharedUsers;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  CostModel(
      {this.costShareId,
      this.planId,
      this.title,
      this.payerId,
      this.note,
      this.amount,
      this.sharedWith,
      this.payer,
      this.sharedUsers,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  CostModel.fromJson(Map<String, dynamic> json) {
    costShareId = json['costShareId'];
    planId = json['planId'];
    title = json['title'];
    payerId = json['payerId'];
    note = json['note'];
    amount = json['amount'];
    sharedWith = json['sharedWith'];
    payer = json['payer'] != null
        ? new FriendDataModel.fromJson(json['payer'])
        : null;
    if (json['sharedUsers'] != null) {
      sharedUsers = <SharedUsers>[];
      json['sharedUsers'].forEach((v) {
        sharedUsers!.add(new SharedUsers.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['costShareId'] = this.costShareId;
    data['planId'] = this.planId;
    data['payerId'] = this.payerId;
    data['title'] = this.title;
    data['note'] = this.note;
    data['amount'] = this.amount;
    data['sharedWith'] = this.sharedWith;
    if (this.payer != null) {
      data['payer'] = this.payer!.toJson();
    }
    if (this.sharedUsers != null) {
      data['sharedUsers'] = this.sharedUsers!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}
