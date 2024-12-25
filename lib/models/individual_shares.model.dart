class IndividualSharesModel {
  String? userId;
  double? amount;

  IndividualSharesModel({
    this.userId,
    this.amount,
  });

  factory IndividualSharesModel.fromJson(Map<String, dynamic> json) {
    return IndividualSharesModel(
      userId: json['userId'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'amount': amount,
    };
  }
}
