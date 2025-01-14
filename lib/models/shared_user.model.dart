class SharedUsers {
  String? sharedUserid;
  String? costShareId;
  String? userId;
  double? amount;
  bool? isPaid;

  SharedUsers(
      {this.sharedUserid,
      this.costShareId,
      this.userId,
      this.amount,
      this.isPaid});

  SharedUsers.fromJson(Map<String, dynamic> json) {
    sharedUserid = json['SharedUserid'];
    costShareId = json['costShareId'];
    userId = json['userId'];
    amount = json['amount'] != null ? json['amount'].toDouble() : 0;
    isPaid = json['isPaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SharedUserid'] = this.sharedUserid;
    data['costShareId'] = this.costShareId;
    data['userId'] = this.userId;
    data['amount'] = this.amount;
    data['isPaid'] = this.isPaid;
    return data;
  }
}
