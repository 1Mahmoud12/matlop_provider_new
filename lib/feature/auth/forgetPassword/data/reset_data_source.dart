import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/core/utils/constants.dart';

abstract class ResetPasswordDataSourceInterface {
  Future<Either<Failure, String>> postResetPassword({
    required String mobileNumber,
    required bool isArabic,
  });

  Future<Either<Failure, String>> verifyOtp({
    required String mobile,
    required String otp,
  });

  Future<Either<Failure, String>> resetPassword({
    required String mobile,
    required String password,
    required String confirmPassword,
    required String verificationCode,
  });
}

class ResetPasswordDataSource extends ResetPasswordDataSourceInterface {
  @override
  Future<Either<Failure, String>> postResetPassword({
    required String mobileNumber,
    required bool isArabic,
  }) async {
    try {
      const endpoint = EndPoints.forgetPassword;
      final response = await DioHelper.postData(
        endPoint: endpoint,
        data: {
          'identifier': '0$mobileNumber',
          'isTechnicalUser': true,
        },
      );
      log('postResetPassword response.data ${response.data.runtimeType}');
      if (response.data['code'] == 1 || response.data['isSuccess'] == false) {
        return left(ServerFailure(response.data['message'] ?? 'Error'));
      }
      log('postResetPassword response: ${response.data}');

      String message = response.data['message'] ?? '';
      if (response.data['data'] != null && response.data['data'] is Map) {
        final dataMap = response.data['data'];
        if (isArabic) {
          message = dataMap['message'] ?? message;
        } else {
          message = dataMap['messageEn'] ?? dataMap['message'] ?? message;
        }
      }

      return right(message);
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
          'mobile': '0$mobile',
          'otpCode': otp,
        },
      );
      if (response.data['code'] == 1 || response.data['isSuccess'] == false) {
        return left(ServerFailure(response.data['message'] ?? 'Error'));
      }
      return right(response.data['message'] ?? '');
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
    required String verificationCode,
  }) async {
    try {
      const endpoint = EndPoints.resetPassword;
      final response = await DioHelper.postData(
        endPoint: endpoint,
        data: {
          'identifier': '0$mobile',
          'verificationCode': verificationCode,
          'newPassword': password,
          'isTechnicalUser': true,
        },
      );
      if (response.data['code'] == 1 || response.data['isSuccess'] == false) {
        return left(ServerFailure(response.data['message'] ?? 'Error'));
      }
      return right(response.data['message'] ?? '');
    } catch (error) {
      log(error.toString());
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }
}
