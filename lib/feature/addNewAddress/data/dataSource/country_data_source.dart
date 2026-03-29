import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/country_model.dart';
import 'package:matlop_provider/main.dart';

class CountryDataSource {
  static Future<Either<Failure, CountryModel>> getCounties({required BuildContext context}) async {
    try {
      final response = await DioHelper.getData(url: EndPoints.GetCountry, context: context);
      return right(CountryModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        logger.d(e.response?.toString());
        if ('${e.response != null && e.response?.data != null && e.response?.data['code']}' == '1') {
          return right(CountryModel.fromJson(e.response?.data));
        }
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
