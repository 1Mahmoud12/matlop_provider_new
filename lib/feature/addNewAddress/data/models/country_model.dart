

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
  final String currency;
  final String nationality;
  final String phoneLength;
  final String phoneCode;
  final String content;
  final String shortName;
  final String timeZone;
  final bool status;

  CountryData({
    required this.countryId,
    this.img,
    required this.enName,
    required this.arName,
    required this.currency,
    required this.nationality,
    required this.phoneLength,
    required this.phoneCode,
    required this.content,
    required this.shortName,
    required this.timeZone,
    required this.status,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) {
    return CountryData(
      countryId: json['countryId'] ?? -1,  // Default to -1 if 'countryId' is null
      img: json['img'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if 'img' is null
      enName: json['enName'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if 'enName' is null
      arName: json['arName'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if 'arName' is null
      currency: json['currency'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if 'currency' is null
      nationality: json['nationality'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if 'nationality' is null
      phoneLength: json['phoneLength'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if 'phoneLength' is null
      phoneCode: json['phoneCode'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if 'phoneCode' is null
      content: json['content'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if 'content' is null
      shortName: json['shortName'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if 'shortName' is null
      timeZone: json['timeZone'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if 'timeZone' is null
      status: json['status'] ?? false,  // Default to false if 'status' is null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countryId': countryId,
      'img': img ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if 'img' is null
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
    };
  }
}
