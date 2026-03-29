import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/districts_model.dart';

class DistrictsDataSource {
  static Future<Either<Failure, DistrictModel>> getDistricts({required BuildContext context, required int cityId}) async {
    try {
      final response = await DioHelper.getData(url: '${EndPoints.getDistricts}$cityId', context: context);
      log('ahmed${response.data}');
      return right(DistrictModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
