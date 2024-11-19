class UserModel {
  String? id;
  String? phone;
  Null bio;
  bool? isPublic;
  bool? isAdmin;
  bool? isEmailVerified;
  String? createdAt;
  String? updatedAt;
  Null avatarId;
  Null isPaymentExpenseId;
  Null avatar;

  UserModel(
      {this.id,
      this.phone,
      this.bio,
      this.isPublic,
      this.isAdmin,
      this.isEmailVerified,
      this.createdAt,
      this.updatedAt,
      this.avatarId,
      this.isPaymentExpenseId,
      this.avatar});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    bio = json['bio'];
    isPublic = json['isPublic'];
    isAdmin = json['isAdmin'];
    isEmailVerified = json['isEmailVerified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    avatarId = json['avatarId'];
    isPaymentExpenseId = json['isPaymentExpenseId'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['bio'] = this.bio;
    data['isPublic'] = this.isPublic;
    data['isAdmin'] = this.isAdmin;
    data['isEmailVerified'] = this.isEmailVerified;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['avatarId'] = this.avatarId;
    data['isPaymentExpenseId'] = this.isPaymentExpenseId;
    data['avatar'] = this.avatar;
    return data;
  }
}
