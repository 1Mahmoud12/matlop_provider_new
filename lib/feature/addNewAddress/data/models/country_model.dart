

import 'package:matlop_provider/core/utils/constants.dart';

class CountryModel {
  final int code;
  final String message;
  final List<CountryData> data;

  CountryModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List;
    final List<CountryData> countryDataList = list.map((i) => CountryData.fromJson(i)).toList();

    return CountryModel(
      code: json['code'] ?? -1,  // Default to -1 if 'code' is null
      message: json['message'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if 'message' is null
      data: countryDataList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class CountryData {
  final int countryId;
  final String? img; // Nullable field
  final String enName;
  final String arName;
  final String? currency;
  final String? nationality;
  final String? phoneLength;
  final String phoneCode;
  final String? content;
  final String? shortName;
  final String? timeZone;
  final bool status;
  final int currencyId;
  final int minPhoneLength;
  final int maxPhoneLength;
  final String? paymentUrl;
  final String? phoneValidationMessageAr;
  final String? phoneValidationMessageEn;
  final String? taxName;
  final num? taxPercentage;
  final int? packagePriceDisplayMode;

  CountryData({
    required this.countryId,
    this.img,
    required this.enName,
    required this.arName,
    this.currency,
    this.nationality,
    this.phoneLength,
    required this.phoneCode,
    this.content,
    this.shortName,
    this.timeZone,
    required this.status,
    required this.currencyId,
    required this.minPhoneLength,
    required this.maxPhoneLength,
    this.paymentUrl,
    this.phoneValidationMessageAr,
    this.phoneValidationMessageEn,
    this.taxName,
    this.taxPercentage,
    this.packagePriceDisplayMode,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) {
    return CountryData(
      countryId: json['countryId'] ?? -1,
      img: json['img'],
      enName: json['enName'] ?? Constants.unKnownValue,
      arName: json['arName'] ?? Constants.unKnownValue,
      currency: json['currency'],
      nationality: json['nationality'],
      phoneLength: json['phoneLength'],
      phoneCode: json['phoneCode'] ?? Constants.unKnownValue,
      content: json['content'],
      shortName: json['shortName'],
      timeZone: json['timeZone'],
      status: json['status'] ?? false,
      currencyId: json['currencyId'] ?? -1,
      minPhoneLength: json['minPhoneLength'] ?? 0,
      maxPhoneLength: json['maxPhoneLength'] ?? 0,
      paymentUrl: json['paymentUrl'],
      phoneValidationMessageAr: json['phoneValidationMessageAr'],
      phoneValidationMessageEn: json['phoneValidationMessageEn'],
      taxName: json['taxName'],
      taxPercentage: json['taxPercentage'],
      packagePriceDisplayMode: json['packagePriceDisplayMode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countryId': countryId,
      'img': img,
      'enName': enName,
      'arName': arName,
      'currency': currency,
      'nationality': nationality,
      'phoneLength': phoneLength,
      'phoneCode': phoneCode,
      'content': content,
      'shortName': shortName,
      'timeZone': timeZone,
      'status': status,
      'currencyId': currencyId,
      'minPhoneLength': minPhoneLength,
      'maxPhoneLength': maxPhoneLength,
      'paymentUrl': paymentUrl,
      'phoneValidationMessageAr': phoneValidationMessageAr,
      'phoneValidationMessageEn': phoneValidationMessageEn,
      'taxName': taxName,
      'taxPercentage': taxPercentage,
      'packagePriceDisplayMode': packagePriceDisplayMode,
    };
  }
}
