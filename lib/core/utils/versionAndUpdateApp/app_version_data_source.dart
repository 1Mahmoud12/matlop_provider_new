import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/core/utils/versionAndUpdateApp/app_version_model.dart';
import 'package:matlop_provider/main.dart';

class AppVersionDataSource {
  static Future<Either<Failure, AppVersionModel>> getAppVersion() async {
    try {
      final platform = Platform.isAndroid ? 'android' : 'ios';
      final response = await DioHelper.getData(
        url: EndPoints.appVersion,
      );
      logger.d(response.data);
      return right(AppVersionModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  static Future<String> getCurrentAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
