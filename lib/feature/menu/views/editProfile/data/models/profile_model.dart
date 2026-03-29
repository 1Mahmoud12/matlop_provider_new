
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/utils/constants.dart';

class ProfileModel {
  ProfileModel({
    this.code,
    this.message,
    this.data,
  });

  ProfileModel.fromJson(dynamic json) {
    code = json['code'] ?? -1; // Default to -1 if null
    message = json['message'] ?? 'Unknown'; // Default to 'Unknown' if null
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  int? code; // Nullable integer
  String? message; // Nullable string
  Data? data; // Nullable Data object

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message ?? 'Unknown'; // Ensure message is never null
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.userId,
    this.userTypeId,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.isActive,
    this.gender,
    this.dateOfBirth,
    this.mobileNumber,
    this.imgSrc,
    this.pinCode,
    this.password,
    this.notes,
    this.technicalSpecialistId,
  });

  Data.fromJson(dynamic json) {
    userId = json['userId'] ?? -1; // Default to -1 if null
    userTypeId = json['userTypeId'] ?? -1; // Default to -1 if null
    firstName = json['firstName'] ?? 'Unknown'; // Default to 'Unknown' if null
    lastName = json['lastName'] ?? 'Unknown'; // Default to 'Unknown' if null
    username = json['username'] ?? 'Unknown'; // Default to 'Unknown' if null
    email = json['email'] ?? 'Unknown'; // Default to 'Unknown' if null
    isActive = json['isActive'] ?? false; // Default to false if null
    gender = json['gender'] ?? -1; // Default to -1 if null (assuming gender is represented by an integer)
    dateOfBirth = json['dateOfBirth'] ?? DateTime(2000).toString(); // Ensure dateOfBirth is never null
    mobileNumber = json['mobileNumber'] ?? 'Unknown'; // Default to 'Unknown' if null
    imgSrc = json['imgSrc'] != null ? '${EndPoints.domain}${json['imgSrc']}' : Constants.unKnownValue; // Default to 'Unknown' if null
    pinCode = json['pinCode'] ?? ''; // Default to empty string if null
    password = json['password'] ?? ''; // Default to empty string if null
    notes = json['notes'] ?? ''; // Default to empty string if null
    technicalSpecialistId = json['technicalSpecialistId'] ?? ''; // Default to empty string if null
  }

  int? userId; // Nullable integer
  int? userTypeId; // Nullable integer
  String? firstName; // Nullable string
  String? lastName; // Nullable string
  String? username; // Nullable string
  String? email; // Nullable string
  bool? isActive; // Nullable boolean
  int? gender; // Nullable integer
  num? technicalSpecialistId; // Nullable integer
  String? dateOfBirth; // Nullable string
  String? mobileNumber; // Nullable string
  String? imgSrc; // Nullable string
  dynamic pinCode; // Nullable dynamic
  dynamic password; // Nullable dynamic
  dynamic notes; // Nullable dynamic

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['userTypeId'] = userTypeId;
    map['firstName'] = firstName ?? 'Unknown'; // Ensure firstName is never null
    map['lastName'] = lastName ?? 'Unknown'; // Ensure lastName is never null
    map['username'] = username ?? 'Unknown'; // Ensure username is never null
    map['email'] = email ?? 'Unknown'; // Ensure email is never null
    map['isActive'] = isActive ?? false; // Ensure isActive is never null
    map['gender'] = gender ?? -1; // Ensure gender is never null
    map['dateOfBirth'] = dateOfBirth ??  DateTime(2000).toString(); // Ensure dateOfBirth is never null
    map['mobileNumber'] = mobileNumber ?? 'Unknown'; // Ensure mobileNumber is never null
    map['imgSrc'] = imgSrc ?? 'Unknown'; // Ensure imgSrc is never null
    map['pinCode'] = pinCode ?? ''; // Ensure pinCode is never null
    map['password'] = password ?? ''; // Ensure password is never null
    map['notes'] = notes ?? ''; // Ensure notes is never null
    map['technicalSpecialistId'] = technicalSpecialistId ?? ''; // Ensure notes is never null
    return map;
  }
}
