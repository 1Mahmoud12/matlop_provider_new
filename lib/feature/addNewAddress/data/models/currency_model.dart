class CurrencyModel {
  CurrencyModel({
    this.data,
    this.isSuccess,
    this.domainError,
    this.error,
    this.message,
    this.errors,
    this.statusCode,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      data: json['data'] != null ? (json['data'] as List).map((i) => CurrencyData.fromJson(i)).toList() : null,
      isSuccess: json['isSuccess'],
      domainError: json['domainError'],
      error: json['error'],
      message: json['message'],
      errors: json['errors'] != null ? List<dynamic>.from(json['errors']) : null,
      statusCode: json['statusCode'],
    );
  }

  List<CurrencyData>? data;
  bool? isSuccess;
  dynamic domainError;
  String? error;
  String? message;
  List<dynamic>? errors;
  int? statusCode;

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((e) => e.toJson()).toList(),
      'isSuccess': isSuccess,
      'domainError': domainError,
      'error': error,
      'message': message,
      'errors': errors,
      'statusCode': statusCode,
    };
  }
}

class CurrencyData {
  CurrencyData({
    this.currencyId,
    this.enName,
    this.arName,
    this.code,
    this.symbol,
    this.image,
    this.isActive,
  });

  factory CurrencyData.fromJson(Map<String, dynamic> json) {
    return CurrencyData(
      currencyId: json['currencyId'],
      enName: json['enName'],
      arName: json['arName'],
      code: json['code'],
      symbol: json['symbol'],
      image: json['image'],
      isActive: json['isActive'],
    );
  }

  int? currencyId;
  String? enName;
  String? arName;
  String? code;
  String? symbol;
  String? image;
  bool? isActive;

  Map<String, dynamic> toJson() {
    return {
      'currencyId': currencyId,
      'enName': enName,
      'arName': arName,
      'code': code,
      'symbol': symbol,
      'image': image,
      'isActive': isActive,
    };
  }
}
