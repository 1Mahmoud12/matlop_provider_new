
import 'package:matlop_provider/core/utils/constants.dart';

class CityModel {
  final int code;
  final String message;
  final List<CityData> data;

  CityModel({
    required this.code,
    required this.message,
    required this.data,
  });

  // Factory constructor to create Response from JSON
  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      code: json['code'],
      message: json['message'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if null
      data: List<CityData>.from(json['data'].map((x) => CityData.fromJson(x))),
    );
  }

  // Method to convert Response to JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class CityData {
  final int cityId;
  final String enName;
  final String arName;
  final String postalCode;
  final String shortCut;
  final String latitude;
  final String longitude;
  final bool status;
  final int countryId;

  CityData({
    required this.cityId,
    required this.enName,
    required this.arName,
    required this.postalCode,
    required this.shortCut,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.countryId,
  });

  // Factory constructor to create City from JSON
  factory CityData.fromJson(Map<String, dynamic> json) {
    return CityData(
      cityId: json['cityId'] ?? -1,  // Default to -1 if 'cityId' is null
      enName: json['enName'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if null
      arName: json['arName'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if null
      postalCode: json['postalCode'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if null
      shortCut: json['shortCut'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if null
      latitude: json['latitude'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if null
      longitude: json['longitude'] ?? Constants.unKnownValue,  // Default to Constants.unKnownValue if null
      status: json['status'] ?? false,  // Default to false if 'status' is null
      countryId: json['countryId'] ?? -1,  // Default to -1 if 'countryId' is null
    );
  }

  // Method to convert City to JSON
  Map<String, dynamic> toJson() {
    return {
      'cityId': cityId,
      'enName': enName,
      'arName': arName,
      'postalCode': postalCode,
      'shortCut': shortCut,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
      'countryId': countryId,
    };
  }
}
