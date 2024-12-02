import 'package:kiwis_flutter/models/friend_data.model.dart';

class MemberModel {
  String? groupId;
  String? userId;
  String? role;
  String? joinedAt;
  FriendDataModel? user;

  MemberModel({this.groupId, this.userId, this.role, this.joinedAt, this.user});

  MemberModel.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'];
    userId = json['userId'];
    role = json['role'];
    joinedAt = json['joinedAt'];
    user = json['user'] != null
        ? new FriendDataModel.fromJson(json['user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupId'] = this.groupId;
    data['userId'] = this.userId;
    data['role'] = this.role;
    data['joinedAt'] = this.joinedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
