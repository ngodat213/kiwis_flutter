import 'package:kiwis_flutter/core/constants/app.value.dart';
import 'package:kiwis_flutter/models/cloudinary_image.model.dart';
import 'package:kiwis_flutter/models/friend_data.model.dart';
import 'package:kiwis_flutter/models/member.model.dart';
import 'package:kiwis_flutter/models/message.model.dart';

class GroupModel {
  String? groupId;
  String? name;
  String? createdById;
  String? createdAt;
  String? type;
  CloudinaryImageModel? avatar;
  FriendDataModel? createdBy;
  List<MemberModel>? members;
  List<MessageModel>? messages;
  // List<Null>? plans;
  // List<Null>? realtimePosts;

  GroupModel({
    this.groupId,
    this.name,
    this.createdById,
    this.createdAt,
    this.type,
    this.avatar,
    this.createdBy,
    this.members,
    // this.messages,
    // this.plans,
    // this.realtimePosts
  });

  bool isGroupChat() => type?.compareTo('GROUP') == 0;

  String groupName() => name ?? members!.first.user!.fullName;

  String groupAvatarUrl() {
    if (avatar?.imageUrl != null) {
      return avatar!.imageUrl!;
    } else if (members?.first.user?.avatar?.imageUrl != null) {
      return members!.first.user!.avatar!.imageUrl!;
    }
    return AppValues.defaultAvatar;
  }

  String lastMessage() {
    if (messages?.isNotEmpty ?? false) {
      return messages!.last.text!;
    }
    return '';
  }

  GroupModel.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'];
    name = json['name'];
    createdById = json['createdById'];
    createdAt = json['createdAt'];
    type = json['type'];
    avatar = json['avatar'] != null
        ? new CloudinaryImageModel.fromJson(json['avatar'])
        : null;
    createdBy = json['createdBy'] != null
        ? new FriendDataModel.fromJson(json['createdBy'])
        : null;
    if (json['members'] != null) {
      members = <MemberModel>[];
      json['members'].forEach((v) {
        members!.add(new MemberModel.fromJson(v));
      });
    }
    if (json['messages'] != null) {
      messages = <MessageModel>[];
      json['messages'].forEach((v) {
        messages!.add(new MessageModel.fromJson(v));
      });
    }
    // if (json['plans'] != null) {
    //   plans = <Null>[];
    //   json['plans'].forEach((v) {
    //     plans!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['realtimePosts'] != null) {
    //   realtimePosts = <Null>[];
    //   json['realtimePosts'].forEach((v) {
    //     realtimePosts!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupId'] = this.groupId;
    data['name'] = this.name;
    data['createdById'] = this.createdById;
    data['createdAt'] = this.createdAt;
    data['type'] = this.type;
    if (this.avatar != null) {
      data['avatar'] = this.avatar!.toJson();
    }
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    // if (this.plans != null) {
    //   data['plans'] = this.plans!.map((v) => v.toJson()).toList();
    // }
    // if (this.realtimePosts != null) {
    //   data['realtimePosts'] =
    //       this.realtimePosts!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
