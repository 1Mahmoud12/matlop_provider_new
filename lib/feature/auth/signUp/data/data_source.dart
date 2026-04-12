import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/feature/auth/signUp/data/technical_special_list_model.dart';

import 'package:matlop_provider/feature/auth/login/data/models/login_model.dart';
import 'model.dart';

abstract class RegisterDataSource {
  Future<Either<Failure, LoginModel>> register({required SingUpParameters params});

  Future<Either<Failure, TechnicalSpecialListModel>> getAllTechnicalSpecialList();
}

class RegisterDataSourceImpl implements RegisterDataSource {
  @override
  Future<Either<Failure, LoginModel>> register({required SingUpParameters params}) async {
    try {
      // Make the POST request
      final response = await DioHelper.postData(
        endPoint: EndPoints.register,
        data: params.toJson(),
      );

      if (response.data['code'] == 1 || response.data['isSuccess'] == false) {
        return left(ServerFailure(response.data['message'] ?? 'Error'));
      }

      return right(LoginModel.fromJson(response.data));
    } catch (error) {
      if (error is DioException) {
        log('Error: ${error.message}');
        return left(ServerFailure.fromDioException(error));
      }
      log('Error: $error');
      return left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, TechnicalSpecialListModel>> getAllTechnicalSpecialList() async {
    try {
      // Make the POST request
      final response = await DioHelper.getData(
        url: EndPoints.getAllTechnicalSpecialist,
      );

      if (response.data['code'] == 1) {
        return left(ServerFailure(response.data['message']));
      }

      return right(TechnicalSpecialListModel.fromJson(response.data));
    } catch (error) {
      if (error is DioException) {
        log('Error: ${error.message}');
        return left(ServerFailure.fromDioException(error));
      }
      log('Error: $error');
      return left(ServerFailure(error.toString()));
    }
  }
}
