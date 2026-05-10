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
    this.fullName,
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
    this.workerTypeId,
    List<ProfileCity>? cities,
    List<ProfileService>? services,
  })  : cities = cities ?? [],
        services = services ?? [];

  Data.fromJson(dynamic json) {
    userId = json['userId'] ?? -1;
    userTypeId = json['userTypeId'] ?? json['roleId'] ?? -1;
    firstName = json['firstName']?.toString() ?? '';
    lastName = json['lastName']?.toString() ?? '';
    // Prefer the dedicated fullName field; fall back to composing from firstName + lastName
    final rawFullName = json['fullName']?.toString();
    if (rawFullName != null && rawFullName.isNotEmpty) {
      fullName = rawFullName;
    } else {
      final fn = firstName ?? '';
      final ln = lastName ?? '';
      fullName = (fn.isEmpty && ln.isEmpty) ? '' : '$fn $ln'.trim();
    }
    username = json['username']?.toString() ?? json['userName']?.toString() ?? '';
    email = json['email']?.toString() ?? '';
    isActive = json['isActive'] ?? false;
    gender = (json['gender'] ?? json['genderId']) ?? -1;
    dateOfBirth = json['dateOfBirth']?.toString();
    mobileNumber = json['mobileNumber']?.toString() ?? '';
    final rawImg = json['imgSrc']?.toString().trim();
    if (rawImg == null || rawImg.isEmpty) {
      imgSrc = '';
    } else if (rawImg.startsWith('http')) {
      imgSrc = rawImg;
    } else {
      imgSrc = '${EndPoints.domain}$rawImg';
    }
    pinCode = json['pinCode'] ?? '';
    password = json['password'] ?? '';
    notes = json['notes'] ?? '';
    workerTypeId = json['workerTypeId'] != null ? (json['workerTypeId'] as num).toInt() : null;
    technicalSpecialistId = json['technicalSpecialistId'] != null
        ? num.tryParse(json['technicalSpecialistId'].toString())
        : null;
    cities = (json['cities'] as List<dynamic>? ?? []).map((e) => ProfileCity.fromJson(e)).toList();
    services = (json['services'] as List<dynamic>? ?? []).map((e) => ProfileService.fromJson(e)).toList();
  }

  int? userId;
  int? userTypeId;
  String? fullName;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  bool? isActive;
  int? gender;
  int? workerTypeId;
  num? technicalSpecialistId;
  late List<ProfileCity> cities;
  late List<ProfileService> services;
  String? dateOfBirth;
  String? mobileNumber;
  String? imgSrc;
  dynamic pinCode;
  dynamic password;
  dynamic notes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['userTypeId'] = userTypeId;
    map['fullName'] = fullName ?? '';
    map['firstName'] = firstName ?? '';
    map['lastName'] = lastName ?? '';
    map['username'] = username ?? '';
    map['email'] = email ?? '';
    map['isActive'] = isActive ?? false;
    map['gender'] = gender ?? -1;
    map['dateOfBirth'] = dateOfBirth ?? '';
    map['mobileNumber'] = mobileNumber ?? '';
    map['imgSrc'] = imgSrc ?? '';
    map['pinCode'] = pinCode ?? '';
    map['password'] = password ?? '';
    map['notes'] = notes ?? '';
    map['workerTypeId'] = workerTypeId;
    map['technicalSpecialistId'] = technicalSpecialistId;
    map['cities'] = cities.map((e) => e.toJson()).toList();
    map['services'] = services.map((e) => e.toJson()).toList();
    return map;
  }
}

class ProfileCity {
  final int cityId;
  final String cityNameAr;
  final String cityNameEn;

  ProfileCity({required this.cityId, required this.cityNameAr, required this.cityNameEn});

  factory ProfileCity.fromJson(Map<String, dynamic> json) {
    return ProfileCity(
      cityId: json['cityId'] ?? -1,
      cityNameAr: json['cityNameAr'] ?? '',
      cityNameEn: json['cityNameEn'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'cityId': cityId,
        'cityNameAr': cityNameAr,
        'cityNameEn': cityNameEn,
      };
}

class ProfileService {
  final int serviceId;
  final String serviceNameAr;
  final String serviceNameEn;

  ProfileService({required this.serviceId, required this.serviceNameAr, required this.serviceNameEn});

  factory ProfileService.fromJson(Map<String, dynamic> json) {
    return ProfileService(
      serviceId: json['serviceId'] ?? -1,
      serviceNameAr: json['serviceNameAr'] ?? '',
      serviceNameEn: json['serviceNameEn'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'serviceId': serviceId,
        'serviceNameAr': serviceNameAr,
        'serviceNameEn': serviceNameEn,
      };
}