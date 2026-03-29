import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/feature/menu/views/privacy&policy/data/models/privacy_and_policy_model.dart';
import 'package:matlop_provider/main.dart';

class PrivacyAndPolicyDataSource {
  static Future<Either<Failure, PrivacyAndPolicyModel>> getPrivacyAndPolicy(BuildContext context) async {
    try {
      final response = await DioHelper.getData(url: EndPoints.privacyAndPolicy, context: context);


      return right(PrivacyAndPolicyModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        if('${e.response?.data['code']}'=='1'){
        return   right(PrivacyAndPolicyModel.fromJson({}));
        }
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
