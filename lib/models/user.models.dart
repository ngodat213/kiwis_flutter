import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/models/cloudinary_image.model.dart';
import 'package:kiwis_flutter/models/friendship.model.dart';

class UserModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? avatarId;
  bool? isActive;
  bool? emailVerified;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  CloudinaryImageModel? avatar;
  List<FriendshipModel>? friends;
  // List<Null>? groups;
  // List<Null>? plans;
  // List<Null>? postFeeds;

  UserModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.avatarId,
    this.isActive,
    this.emailVerified,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.avatar,
    // this.groups,
    // this.plans,
    // this.postFeeds.
  });

  String get avatarUrl => avatar?.imageUrl ?? AppValues.defaultAvatar;

  String get displayName => "$firstName $lastName";

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    avatarId = json['avatarId'];
    isActive = json['isActive'];
    emailVerified = json['emailVerified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    avatar = json['avatar'] != null
        ? new CloudinaryImageModel.fromJson(json['avatar'])
        : null;
    // if (json['groups'] != null) {
    //   groups = <Null>[];
    //   json['groups'].forEach((v) {
    //     groups!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['plans'] != null) {
    //   plans = <Null>[];
    //   json['plans'].forEach((v) {
    //     plans!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['postFeeds'] != null) {
    //   postFeeds = <Null>[];
    //   json['postFeeds'].forEach((v) {
    //     postFeeds!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['friends'] != null) {
      friends = <FriendshipModel>[];
      json['friends'].forEach((v) {
        friends!.add(new FriendshipModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['avatarId'] = this.avatarId;
    data['isActive'] = this.isActive;
    data['emailVerified'] = this.emailVerified;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.avatar != null) {
      data['avatar'] = this.avatar!.toJson();
    }
    // if (this.groups != null) {
    //   data['groups'] = this.groups!.map((v) => v.toJson()).toList();
    // }
    // if (this.plans != null) {
    //   data['plans'] = this.plans!.map((v) => v.toJson()).toList();
    // }
    // if (this.postFeeds != null) {
    //   data['postFeeds'] = this.postFeeds!.map((v) => v.toJson()).toList();
    // }
    if (this.friends != null) {
      data['friends'] = this.friends!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
