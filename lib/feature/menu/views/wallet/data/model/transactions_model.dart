class TransactionsModel {
  TransactionsModel({
    this.code,
    this.message,
    this.data,
  });

  TransactionsModel.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ItemTransaction.fromJson(v));
      });
    }
  }

  int? code;
  dynamic message;
  List<ItemTransaction>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ItemTransaction {
  ItemTransaction({
    this.walletTransactionId,
    this.transactionType,
    this.amount,
    this.userId,
    this.creationTime,
  });

  ItemTransaction.fromJson(dynamic json) {
    walletTransactionId = json['walletTransactionId'];
    transactionType = json['transactionType'];
    amount = json['amount'];
    userId = json['userId'];
    creationTime = json['creationTime'];
  }

  num? walletTransactionId;
  String? transactionType;
  num? amount;
  num? userId;
  String? creationTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['walletTransactionId'] = walletTransactionId;
    map['transactionType'] = transactionType;
    map['amount'] = amount;
    map['userId'] = userId;
    map['creationTime'] = creationTime;
    return map;
  }
}
