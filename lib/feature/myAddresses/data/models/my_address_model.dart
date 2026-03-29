
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/country_model.dart';

class MyAddressModel {
  int code;
  String message;
  List<LocationData> data;

  // Constructor
  MyAddressModel({
    required this.code,
    required this.message,
    required this.data,
  });

  // Factory method to create an instance from JSON
  factory MyAddressModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return MyAddressModel(
        code: 0, // Default value for code
        message: Constants.unKnownValue, // Default value for message
        data: [], // Empty list as default for data
      );
    }

    return MyAddressModel(
      code: json['code'] ?? 0, // Provide default value if code is null
      message: json['message'] ?? Constants.unKnownValue, // Default for message
      data: (json['data'] != null && json['data'] is List)
          ? List<LocationData>.from(
              json['data'].map((location) => LocationData.fromJson(location)),
            )
          : [], // Handle null or non-list 'data'
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.map((location) => location.toJson()).toList(),
    };
  }
}

class LocationData {
  int locationId;
  String enName;
  int countryId;
  int cityId;
  int districtId;
  String blockNo;
  String latitude;
  String longitude;
  int userId;

  // Constructor
  LocationData({
    required this.locationId,
    required this.enName,
    required this.countryId,
    required this.cityId,
    required this.districtId,
    required this.blockNo,
    required this.latitude,
    required this.longitude,
    required this.userId,
  });

  // Factory method to create an instance from JSON
  factory LocationData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return LocationData(
        locationId: 0, // Default value for locationId
        enName: Constants.unKnownValue, // Default for enName
        countryId: 0, // Default value for countryId
        cityId: 0, // Default value for cityId
        districtId: 0, // Default value for districtId
        blockNo: Constants.unKnownValue, // Default for blockNo
        latitude: Constants.unKnownValue, // Default for latitude
        longitude: Constants.unKnownValue, // Default for longitude

        userId: 0, // Default value for userId
      );
    }

    return LocationData(
      locationId: json['locationId'] ?? 0, // Default value for locationId
      enName: json['name'] ?? Constants.unKnownValue,
      // Default for enName
      countryId: json['countryId'] ?? 0, // Default value for countryId
      cityId: json['cityId'] ?? 0, // Default value for cityId
      districtId: json['districtId'] ?? 0, // Default value for districtId
      blockNo: json['blockNo'] ?? Constants.unKnownValue, // Default for blockNo
      latitude: json['latitude'] ?? Constants.unKnownValue, // Default for latitude
      longitude: json['longitude'] ?? Constants.unKnownValue, // Default for longitude
      userId: json['userId'] ?? 0, // Default value for userId
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'locationId': locationId,
      'name': enName,
      'countryId': countryId,
      'cityId': cityId,
      'districtId': districtId,
      'blockNo': blockNo,
      'latitude': latitude,
      'longitude': longitude,
      'userId': userId,
    };
  }
}
