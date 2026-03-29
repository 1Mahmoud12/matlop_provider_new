import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/city_model.dart';

class CityDataSource {
  static Future<Either<Failure, CityModel>> getCities({required BuildContext context,required int countryId}) async {
    try {
      final response = await DioHelper.getData(url: '${EndPoints.getCitiesById}$countryId', context: context);
      log('test city endpoint${response.data}');
      return right(CityModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
