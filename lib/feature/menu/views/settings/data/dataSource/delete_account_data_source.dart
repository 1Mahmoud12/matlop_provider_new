import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/core/utils/constants.dart';

class DeleteAccountDataSource {
  static Future<Either<Failure, String>> deleteAccount({
    required BuildContext context,
  }) async {
    try {
      final String tokenToSend = await Constants.messaging.getToken() ?? Constants.fcmToken;
      final response = await DioHelper.deleteData(
        endPoint: EndPoints.deleteAccount,
        data: {'token': tokenToSend},
      );
      return right(response.data['message'] ?? 'account_deleted_successfully');
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
