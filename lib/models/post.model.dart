import 'package:kiwis_flutter/models/cloudinary_image.model.dart';
import 'package:kiwis_flutter/models/friend_data.model.dart';

class PostModel {
  String? realtimePostId;
  String? groupId;
  String? caption;
  String? postedAt;
  String? deletedAt;
  bool? isOnlyUser;
  List<CloudinaryImageModel>? images;
  FriendDataModel? user;

  PostModel(
      {this.realtimePostId,
      this.groupId,
      this.caption,
      this.postedAt,
      this.deletedAt,
      this.isOnlyUser,
      this.images,
      this.user});

  PostModel.fromJson(Map<String, dynamic> json) {
    realtimePostId = json['realtimePostId'];
    groupId = json['groupId'] ?? "";
    caption = json['caption'] ?? "";
    postedAt = json['postedAt'];
    deletedAt = json['deletedAt'] ?? "";
    isOnlyUser = json['isOnlyUser'] ?? false;
    if (json['images'] != null) {
      images = <CloudinaryImageModel>[];
      json['images'].forEach((v) {
        images!.add(CloudinaryImageModel.fromJson(v));
      });
    }
    user = json['user'] != null ? FriendDataModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['realtimePostId'] = this.realtimePostId;
    data['groupId'] = this.groupId;
    data['caption'] = this.caption;
    data['postedAt'] = this.postedAt;
    data['deletedAt'] = this.deletedAt;
    data['isOnlyUser'] = this.isOnlyUser;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }

  //dd-mm-yyyy
  String formatPostedAt() {
    return DateTime.parse(postedAt ?? "").toString().split(" ")[0];
  }
}
