
import 'package:matlop_provider/core/utils/constants.dart';

class DistrictModel {
  int code;
  String message;
  List<DistrictData> data;

  // Constructor
  DistrictModel({
    required this.code,
    required this.message,
    required this.data,
  });

  // Factory method to create an instance from JSON
  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      code: json['code'] ?? -1,
      message: json['message'] ?? Constants.unKnownValue, // Default to "Unknown" if null
      data: json['data'] != null 
            ? (json['data'] as List).map((item) => DistrictData.fromJson(item)).toList() 
            : [],
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class DistrictData {
  int districtId;
  int cityId;
  String cityName;
  String enName;
  String arName;
  String enDescription;
  String arDescription;

  // Constructor
  DistrictData({
    required this.districtId,
    required this.cityId,
    required this.cityName,
    required this.enName,
    required this.arName,
    required this.enDescription,
    required this.arDescription,
  });

  // Factory method to create an instance from JSON
  factory DistrictData.fromJson(Map<String, dynamic> json) {
    return DistrictData(
      districtId: json['districtId'] ?? -1, // Default to -1 if null
      cityId: json['cityId'] ?? -1, // Default to -1 if null
      cityName: json['cityName'] ?? Constants.unKnownValue, // Default to "Unknown" if null
      enName: json['enName'] ?? Constants.unKnownValue, // Default to "Unknown" if null
      arName: json['arName'] ?? Constants.unKnownValue, // Default to "Unknown" if null
      enDescription: json['enDescription'] ?? Constants.unKnownValue, // Default to "Unknown" if null
      arDescription: json['arDescription'] ?? Constants.unKnownValue, // Default to "Unknown" if null
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'districtId': districtId,
      'cityId': cityId,
      'cityName': cityName,
      'enName': enName,
      'arName': arName,
      'enDescription': enDescription,
      'arDescription': arDescription,
    };
  }
}
