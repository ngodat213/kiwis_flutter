import 'package:kiwis_flutter/models/cloudinary_image.model.dart';

class FriendDataModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  CloudinaryImageModel? avatar;

  FriendDataModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.avatar,
  });

  FriendDataModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    avatar = json['avatar'] != null
        ? new CloudinaryImageModel.fromJson(json['avatar'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    if (this.avatar != null) {
      data['avatar'] = this.avatar!.toJson();
    }
    return data;
  }
}
