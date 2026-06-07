import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/feature/menu/data/models/settings_model.dart';
import 'package:matlop_provider/main.dart'; // For logger

class SettingsDataSource {
  static Future<Either<Failure, SettingsModel>> getSettings() async {
    try {
      final response = await DioHelper.getData(
        url: '${EndPoints.getSettings}/current',
      );
      return right(SettingsModel.fromJson(response.data));
    } catch (e) {
      logger.e('error in getSettings $e ');
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
