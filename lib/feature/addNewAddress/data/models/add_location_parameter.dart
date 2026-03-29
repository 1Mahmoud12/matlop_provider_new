
import 'package:matlop_provider/core/utils/constants.dart';

class LocationParameter {
  int countryId;
  int cityId;
  int districtId;
  String blockNo;
  String latitude;
  String longitude;
  int userId;
  String? enName;

  // Constructor
  LocationParameter({
    required this.countryId,
    required this.cityId,
    required this.districtId,
    required this.blockNo,
    required this.latitude,
    required this.longitude,
    required this.userId,
    this.enName,
  });

  // Factory method to create an instance from JSON
  factory LocationParameter.fromJson(Map<String, dynamic> json) {
    return LocationParameter(
      countryId: json['countryId'] ?? -1, // Default to -1 if 'countryId' is null
      cityId: json['cityId'] ?? -1, // Default to -1 if 'cityId' is null
      districtId: json['districtId'] ?? -1, // Default to -1 if 'districtId' is null
      blockNo: json['blockNo'] ?? Constants.unKnownValue, // Use Constants.unKnownValue if 'blockNo' is null
      latitude: json['latitude'] ?? Constants.unKnownValue, // Use Constants.unKnownValue if 'latitude' is null
      longitude: json['longitude'] ?? Constants.unKnownValue, // Use Constants.unKnownValue if 'longitude' is null
      userId: json['userId'] ?? -1, // Default to -1 if 'userId' is null
      enName: json['name'] ?? Constants.unKnownValue, // Use Constants.unKnownValue if 'enName' is null
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'countryId': countryId,
      'cityId': cityId,
      'districtId': districtId,
      'blockNo': blockNo,
      'latitude': latitude,
      'longitude': longitude,
      'userId': userId,
      'name': enName,
    };
  }
}
