import 'package:kiwis_flutter/models/friend_data.model.dart';

class FriendShipModel {
  String? friendshipId;
  String? status;
  String? createdAt;
  FriendDataModel? user;

  FriendShipModel({this.friendshipId, this.status, this.createdAt, this.user});

  FriendShipModel.fromJson(Map<String, dynamic> json) {
    friendshipId = json['friendshipId'];
    status = json['status'];
    createdAt = json['createdAt'];
    user = json['user'] != null
        ? new FriendDataModel.fromJson(json['user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['friendshipId'] = this.friendshipId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
