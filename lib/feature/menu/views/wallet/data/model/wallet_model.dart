class WalletModel {
  WalletModel({
    this.code,
    this.message,
    this.data,
  });

  WalletModel.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  int? code;
  dynamic message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.walletId,
    this.userId,
    this.balance,
  });

  Data.fromJson(dynamic json) {
    walletId = json['walletId'];
    userId = json['userId'];
    balance = json['balance'];
  }

  int? walletId;
  int? userId;
  num? balance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['walletId'] = walletId;
    map['userId'] = userId;
    map['balance'] = balance;
    return map;
  }
}
