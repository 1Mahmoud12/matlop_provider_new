import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/feature/menu/views/termsAndConditions/data/models/terms_and_conditions_model.dart';

class TermAndConditionDataSource {
  static Future<Either<Failure, TermsAndConditionsModel>> getTermAndConditions(BuildContext context) async {
    try {
      final response = await DioHelper.getData(url: EndPoints.getTermAndConditions, context: context);
      return right(TermsAndConditionsModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        if (e.response?.data is Map && '${e.response?.data['code']}' == '1') {
          return right(TermsAndConditionsModel.fromJson({}));
        }
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
