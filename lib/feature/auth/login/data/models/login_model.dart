import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/utils/app_images.dart';
import 'package:matlop_provider/core/utils/constants.dart';

class LoginModel {
  final LoginResponseData? data;
  final bool? isSuccess;
  final dynamic domainError;
  final String? error;
  final String? message;
  final List<dynamic>? errors;
  final int? statusCode;

  LoginModel({
    this.data,
    this.isSuccess,
    this.domainError,
    this.error,
    this.message,
    this.errors,
    this.statusCode,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      data: json['data'] != null ? LoginResponseData.fromJson(json['data']) : null,
      isSuccess: json['isSuccess'],
      domainError: json['domainError'],
      error: json['error'],
      message: json['message'],
      errors: (json['errors'] as List<dynamic>?) ?? <dynamic>[],
      statusCode: json['statusCode'] ?? json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'isSuccess': isSuccess,
      'domainError': domainError,
      'error': error,
      'message': message,
      'errors': errors ?? <dynamic>[],
      'statusCode': statusCode,
    };
  }
}

class LoginResponseData {
  final Profile? profile;
  final String? accessToken;
  final String? refreshToken;
  final List<dynamic>? navigation;

  // Backward compatible fields used in other parts of the app.
  int? get userId => profile?.userId;
  String? get mobileNumber => profile?.mobileNumber;
  String? get name => profile?.fullName ?? profile?.firstName ?? profile?.userName;
  String? get imgSrc => profile?.imgSrc != null && profile!.imgSrc!.isNotEmpty ? '${EndPoints.domain}${profile!.imgSrc!}' : Constants.unKnownValue;

  LoginResponseData({
    this.profile,
    this.accessToken,
    this.refreshToken,
    this.navigation,
  });

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    final profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    final genderValue = (profile?.genderNameEn ?? '').toLowerCase();
    if (genderValue == Gender.female.name.toLowerCase()) {
      AppImages.avatar = AppImages.avatarFemale;
    }
    return LoginResponseData(
      profile: profile,
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      navigation: (json['navigation'] as List<dynamic>?) ?? <dynamic>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile': profile?.toJson(),
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'navigation': navigation ?? <dynamic>[],
    };
  }
}

typedef UserData = LoginResponseData;

class Profile {
  final int? userId;
  final String? fullName;
  final String? firstName;
  final String? email;
  final String? mobileNumber;
  final dynamic dateOfBirth;
  final String? userName;
  final String? imgSrc;
  final int? genderId;
  final String? genderNameEn;
  final String? genderNameAr;
  final int? roleId;
  final String? roleNameEn;
  final String? roleNameAr;
  final int? technicalSpecialistId;
  final String? technicalSpecialistNameEn;
  final String? technicalSpecialistNameAr;
  final int? technicalCategoryId;
  final String? technicalCategoryNameEn;
  final String? technicalCategoryNameAr;
  final int? technicalType;
  final String? technicalTypeNameEn;
  final String? technicalTypeNameAr;
  final bool? isActive;
  final int? countryId;
  final String? countryNameEn;
  final String? countryNameAr;
  final List<ServiceModel>? services;
  final List<CityModel>? cities;
  final List<WorkScheduleModel>? workSchedules;

  Profile({
    this.userId,
    this.fullName,
    this.firstName,
    this.email,
    this.mobileNumber,
    this.dateOfBirth,
    this.userName,
    this.imgSrc,
    this.genderId,
    this.genderNameEn,
    this.genderNameAr,
    this.roleId,
    this.roleNameEn,
    this.roleNameAr,
    this.technicalSpecialistId,
    this.technicalSpecialistNameEn,
    this.technicalSpecialistNameAr,
    this.technicalCategoryId,
    this.technicalCategoryNameEn,
    this.technicalCategoryNameAr,
    this.technicalType,
    this.technicalTypeNameEn,
    this.technicalTypeNameAr,
    this.isActive,
    this.countryId,
    this.countryNameEn,
    this.countryNameAr,
    this.services,
    this.cities,
    this.workSchedules,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      userId: json['userId'],
      fullName: json['fullName'],
      firstName: json['firstName'],
      email: json['email'],
      mobileNumber: json['mobileNumber'],
      dateOfBirth: json['dateOfBirth'],
      userName: json['userName'],
      imgSrc: json['imgSrc'],
      genderId: json['genderId'],
      genderNameEn: json['genderNameEn'],
      genderNameAr: json['genderNameAr'],
      roleId: json['roleId'],
      roleNameEn: json['roleNameEn'],
      roleNameAr: json['roleNameAr'],
      technicalSpecialistId: json['technicalSpecialistId'],
      technicalSpecialistNameEn: json['technicalSpecialistNameEn'],
      technicalSpecialistNameAr: json['technicalSpecialistNameAr'],
      technicalCategoryId: json['technicalCategoryId'],
      technicalCategoryNameEn: json['technicalCategoryNameEn'],
      technicalCategoryNameAr: json['technicalCategoryNameAr'],
      technicalType: json['technicalType'],
      technicalTypeNameEn: json['technicalTypeNameEn'],
      technicalTypeNameAr: json['technicalTypeNameAr'],
      isActive: json['isActive'],
      countryId: json['countryId'],
      countryNameEn: json['countryNameEn'],
      countryNameAr: json['countryNameAr'],
      services: (json['services'] as List<dynamic>?)?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>)).toList() ?? <ServiceModel>[],
      cities: (json['cities'] as List<dynamic>?)?.map((e) => CityModel.fromJson(e as Map<String, dynamic>)).toList() ?? <CityModel>[],
      workSchedules:
          (json['workSchedules'] as List<dynamic>?)?.map((e) => WorkScheduleModel.fromJson(e as Map<String, dynamic>)).toList() ?? <WorkScheduleModel>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'firstName': firstName,
      'email': email,
      'mobileNumber': mobileNumber,
      'dateOfBirth': dateOfBirth,
      'userName': userName,
      'imgSrc': imgSrc,
      'genderId': genderId,
      'genderNameEn': genderNameEn,
      'genderNameAr': genderNameAr,
      'roleId': roleId,
      'roleNameEn': roleNameEn,
      'roleNameAr': roleNameAr,
      'technicalSpecialistId': technicalSpecialistId,
      'technicalSpecialistNameEn': technicalSpecialistNameEn,
      'technicalSpecialistNameAr': technicalSpecialistNameAr,
      'technicalCategoryId': technicalCategoryId,
      'technicalCategoryNameEn': technicalCategoryNameEn,
      'technicalCategoryNameAr': technicalCategoryNameAr,
      'technicalType': technicalType,
      'technicalTypeNameEn': technicalTypeNameEn,
      'technicalTypeNameAr': technicalTypeNameAr,
      'isActive': isActive,
      'countryId': countryId,
      'countryNameEn': countryNameEn,
      'countryNameAr': countryNameAr,
      'services': services?.map((e) => e.toJson()).toList() ?? <Map<String, dynamic>>[],
      'cities': cities?.map((e) => e.toJson()).toList() ?? <Map<String, dynamic>>[],
      'workSchedules': workSchedules?.map((e) => e.toJson()).toList() ?? <Map<String, dynamic>>[],
    };
  }
}

class ServiceModel {
  final int? serviceId;
  final String? serviceNameAr;
  final String? serviceNameEn;

  ServiceModel({
    this.serviceId,
    this.serviceNameAr,
    this.serviceNameEn,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      serviceId: json['serviceId'],
      serviceNameAr: json['serviceNameAr'],
      serviceNameEn: json['serviceNameEn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceId': serviceId,
      'serviceNameAr': serviceNameAr,
      'serviceNameEn': serviceNameEn,
    };
  }
}

class CityModel {
  final int? cityId;
  final String? cityNameAr;
  final String? cityNameEn;

  CityModel({
    this.cityId,
    this.cityNameAr,
    this.cityNameEn,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cityId: json['cityId'],
      cityNameAr: json['cityNameAr'],
      cityNameEn: json['cityNameEn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityId': cityId,
      'cityNameAr': cityNameAr,
      'cityNameEn': cityNameEn,
    };
  }
}

class WorkScheduleModel {
  /// Present on [EndPoints.technicalWorkSchedule] list items.
  final int? id;
  final int? technicalId;
  final String? technicalName;

  final int? dayOfWeek;

  /// Login/profile payload uses [dayNameEn] / [dayNameAr]; list API uses [dayName].
  final String? dayNameEn;
  final String? dayNameAr;
  final String? dayName;

  final String? startTime;
  final String? endTime;
  final num? totalHours;

  WorkScheduleModel({
    this.id,
    this.technicalId,
    this.technicalName,
    this.dayOfWeek,
    this.dayNameEn,
    this.dayNameAr,
    this.dayName,
    this.startTime,
    this.endTime,
    this.totalHours,
  });

  /// Prefer English profile field, then list API `dayName`.
  String get displayDayName => dayNameEn ?? dayName ?? '';

  /// Returns the localized day name based on [locale] ('ar' → Arabic, else English).
  String localizedDayName(String locale) {
    if (locale == 'ar') return dayNameAr ?? dayNameEn ?? dayName ?? '';
    return dayNameEn ?? dayName ?? '';
  }

  factory WorkScheduleModel.fromJson(Map<String, dynamic> json) {
    return WorkScheduleModel(
      id: json['id'],
      technicalId: json['technicalId'],
      technicalName: json['technicalName'],
      dayOfWeek: json['dayOfWeek'],
      dayNameEn: json['dayNameEn'],
      dayNameAr: json['dayNameAr'],
      dayName: json['dayName'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      totalHours: json['totalHours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (technicalId != null) 'technicalId': technicalId,
      if (technicalName != null) 'technicalName': technicalName,
      'dayOfWeek': dayOfWeek,
      'dayNameEn': dayNameEn,
      'dayNameAr': dayNameAr,
      'dayName': dayName,
      'startTime': startTime,
      'endTime': endTime,
      if (totalHours != null) 'totalHours': totalHours,
    };
  }

  /// Body item for [EndPoints.updateTechnicalWorkSchedule].
  Map<String, dynamic> toUpdateScheduleMap() {
    return {
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}
