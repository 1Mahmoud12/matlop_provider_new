import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/feature/auth/login/data/models/login_model.dart';

abstract class WorkScheduleDataSourceInterface {
  Future<Either<Failure, List<WorkScheduleModel>>> getAllTechnicalWorkSchedules();

  Future<Either<Failure, bool>> updateMyWorkSchedule({
    required int technicalUserId,
    required List<Map<String, dynamic>> schedules,
  });
}

class WorkScheduleDataSource implements WorkScheduleDataSourceInterface {
  @override
  Future<Either<Failure, List<WorkScheduleModel>>> getAllTechnicalWorkSchedules() async {
    try {
      final response = await DioHelper.getData(url: EndPoints.technicalWorkSchedule);
      final data = response.data;
      if (data['isSuccess'] == true && data['data'] is List) {
        final list = (data['data'] as List<dynamic>).map((e) => WorkScheduleModel.fromJson(e as Map<String, dynamic>)).toList();
        return right(list);
      }
      return left(ServerFailure(data['error']?.toString() ?? 'Failed to load work schedule'));
    } catch (error) {
      log(error.toString());
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateMyWorkSchedule({
    required int technicalUserId,
    required List<Map<String, dynamic>> schedules,
  }) async {
    try {
      final response = await DioHelper.putData(
        endPoint: EndPoints.updateTechnicalWorkSchedule,
        data: {
          'technicalUserId': technicalUserId,
          'schedules': schedules,
        },
      );
      final data = response.data;
      if (data['isSuccess'] == true) {
        return right(true);
      }
      return left(ServerFailure(data['error']?.toString() ?? 'Failed to update work schedule'));
    } catch (error) {
      log(error.toString());
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }
}
