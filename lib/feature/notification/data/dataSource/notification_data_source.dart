import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/feature/notification/data/models/fire_notification_model.dart';

abstract class NotificationDataSource {
  Future<Either<Failure, FireNotificationModel>> getNotification();

  Future<Either<Failure, String>> readNotification({required int idNotification});
}

class NotificationDataSourceImpl extends NotificationDataSource {
  @override
  Future<Either<Failure, FireNotificationModel>> getNotification() async {
    try {
      final response = await DioHelper.getData(
        url: EndPoints.getNotification,
      );
      return right(FireNotificationModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {

        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> readNotification({required int idNotification}) async {
    try {
      await DioHelper.putData(
        endPoint: EndPoints.markNotification,
        data: {},
        query: {
          'id': idNotification,
        },
      );
      return right('successfully_read_notification'.tr());
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
