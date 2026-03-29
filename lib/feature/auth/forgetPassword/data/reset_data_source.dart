import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';

abstract class ResetPasswordDataSourceInterface {
  Future<Either<Failure, String>> postResetPassword({
    required String mobileNumber,
  });

  Future<Either<Failure, String>> verifyOtp({
    required String mobile,
    required String otp,
  });

  Future<Either<Failure, String>> resetPassword({
    required String mobile,
    required String password,
    required String confirmPassword,
  });
}

class ResetPasswordDataSource extends ResetPasswordDataSourceInterface {
  @override
  Future<Either<Failure, String>> postResetPassword({
    required String mobileNumber,
  }) async {
    try {
      const endpoint = EndPoints.forgetPassword;
      final response = await DioHelper.postData(
        endPoint: endpoint,
        data: {
          'mobileNumber': mobileNumber,
        },
      );
      log('object response.data ${response.data.runtimeType}');
      if (response.data['code'] == 1) {
        return left(ServerFailure(response.data['message']));
      }
      log('response uuu${response.data}');
      return right(response.data['message']);
    } catch (error) {
      log(error.toString());

      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp({
    required String mobile,
    required String otp,
  }) async {
    try {
      const endpoint = EndPoints.verifyForgetPassword;
      final response = await DioHelper.postData(
        endPoint: endpoint,
        data: {
          'mobile': mobile,
          'otpCode': otp,
        },
      );
      if (response.data['code'] == 1) {
        return left(ServerFailure(response.data['message']));
      }
      return right(response.data['message']);
    } catch (error) {
      log(error.toString());

      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword({
    required String mobile,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      const endpoint = EndPoints.resetPassword;
      final response = await DioHelper.postData(
        endPoint: endpoint,
        data: {
          'mobileNumber': mobile,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );
      if (response.data['code'] == 1) {
        return left(ServerFailure(response.data['message']));
      }
      return right(response.data['message']);
    } catch (error) {
      log(error.toString());

      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }
}
