import 'dart:io';

import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/constants_enum.dart';

class FirebaseParams {
  final int userId;
  final String fcmToken;
  final String lang;

  FirebaseParams({required this.userId, required this.fcmToken, required this.lang});

  Map<String, Object> toJson() => {
        'userId': userId,
    'deviceId':Constants.deviceId,
        'deviceType': Platform.isIOS ? DeviceTypeEnum.IOS.index : DeviceTypeEnum.Android.index,
        'token': fcmToken,
    "lang": lang,
        'applicationType': ApplicationTypeEnum.Client.index,
      };
}
