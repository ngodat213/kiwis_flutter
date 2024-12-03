import 'package:kiwis_flutter/models/friend_data.model.dart';
import 'package:kiwis_flutter/services/services.dart';

class MessageModel {
  String? groupId;
  String? messageId;
  String? receiverId;
  String? senderId;
  String? sentAt;
  String? text;
  String? type;
  FriendDataModel? sender;

  MessageModel(
      {this.groupId,
      this.messageId,
      this.receiverId,
      this.senderId,
      this.sentAt,
      this.text,
      this.type});

  bool isMe() {
    return senderId == AuthServices.currentUser?.userId;
  }

  bool isGroup() {
    return this.type == 'GROUP';
  }

  MessageModel.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'];
    messageId = json['messageId'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    sentAt = json['sentAt'];
    text = json['text'];
    type = json['type'];
    sender = json['sender'] != null
        ? FriendDataModel.fromJson(json['sender'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupId'] = this.groupId;
    data['messageId'] = this.messageId;
    data['receiverId'] = this.receiverId;
    data['senderId'] = this.senderId;
    data['sentAt'] = this.sentAt;
    data['text'] = this.text;
    data['type'] = this.type;
    data['sender'] = this.sender?.toJson();
    return data;
  }
}
