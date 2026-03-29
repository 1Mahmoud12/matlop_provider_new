import 'dart:io';

import 'package:matlop_provider/core/utils/constants_enum.dart';

class FirebaseParams {
  final int userId;
  final String fcmToken;

  FirebaseParams({required this.userId, required this.fcmToken});

  Map<String, Object> toJson() => {
        'userId': userId,
        'deviceType': Platform.isIOS ? DeviceTypeEnum.IOS.index : DeviceTypeEnum.Android.index,
        'token': fcmToken,
        'applicationType': ApplicationTypeEnum.Client.index,
      };
}
