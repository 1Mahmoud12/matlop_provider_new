import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/feature/auth/login/data/models/login_model.dart';

abstract class LoginDataSourceInterface {
  Future<Either<Failure, LoginModel>> postLogin({
    required BuildContext context,
    required String phoneNumber,
    required String password,
  });

  Future<Either<Failure, LoginModel>> verifyOtp({
    required String mobile,
    required String otp,
  });
}

class LoginDataSource extends LoginDataSourceInterface {
  @override
  Future<Either<Failure, LoginModel>> postLogin({
    required BuildContext context,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      const endpoint = EndPoints.login;
      final response = await DioHelper.postData(
        endPoint: endpoint,
        context: context,
        data: {'mobileNumber': '0$phoneNumber', 'password': password},
      );
      return right(LoginModel.fromJson(response.data));
    } catch (error) {
      log(error.toString());

      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginModel>> verifyOtp({
    required String mobile,
    required String otp,
  }) async {
    try {
      const endpoint = EndPoints.verifyOtp;
      final response = await DioHelper.postData(
        endPoint: endpoint,
        data: {
          'mobile': '0$mobile',
          'otpCode': otp,
          'loginMethod': 1,
        },
      );
      if (response.data['code'] == 1) {
        return left(ServerFailure(response.data['message']));
      }
      return right(LoginModel.fromJson(response.data));
    } catch (error) {
      log(error.toString());

      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }
}
