import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/utils/app_images.dart';
import 'package:matlop_provider/core/utils/constants.dart';

class LoginModel {
  final int code;
  final String? message;
  final UserData? data;

  LoginModel({
    required this.code,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      code: json['code'] ?? -1,
      message: json['message'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class UserData {
  int? userId;
  int? userTypeId;
  String? accessToken;
  int? accessTokenCreationTime;
  int? expiresIn;
  String? tokenType;
  String? imgSrc;
  String? mobileNumber;
  String? name;

  UserData({
    this.userId,
    this.userTypeId,
    this.accessToken,
    this.accessTokenCreationTime,
    this.expiresIn,
    this.tokenType,
    this.imgSrc,
    this.mobileNumber,
    this.name,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    if ((json['genderName'] ?? '').toLowerCase() == Gender.female.name.toLowerCase()) {
      AppImages.avatar = AppImages.avatarFemale;
    }
    return UserData(
      userId: json['userId'],
      userTypeId: json['userTypeId'],
      accessToken: json['accessToken'],
      imgSrc: json['mobileImgSrc'] != null ? '${EndPoints.domain}${json['mobileImgSrc']}' : Constants.unKnownValue,
      accessTokenCreationTime: json['accessTokenCreationTime'],
      expiresIn: json['expiresIn'],
      tokenType: json['tokenType'],
      mobileNumber: json['mobileNumber'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userTypeId': userTypeId,
      'accessToken': accessToken,
      'imgSrc': imgSrc,
      'accessTokenCreationTime': accessTokenCreationTime,
      'expiresIn': expiresIn,
      'tokenType': tokenType,
      'mobileNumber': mobileNumber,
      'name': name,
    };
  }
}
