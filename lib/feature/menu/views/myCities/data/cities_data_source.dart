import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/city_model.dart';

abstract class CitiesDataSourceInterface {
  /// Returns all available cities from /api/cities
  Future<Either<Failure, List<CityData>>> getAllCities();

  /// Updates the technical's selected cities via PUT /api/technicals/cities
  Future<Either<Failure, bool>> updateMyCities({
    required int technicalUserId,
    required List<int> cityIds,
  });
}

class CitiesDataSource extends CitiesDataSourceInterface {
  @override
  Future<Either<Failure, List<CityData>>> getAllCities() async {
    try {
      final response = await DioHelper.getData(url: EndPoints.getCities);
      final data = response.data;
      if (data['isSuccess'] == true) {
        final cities = (data['data'] as List<dynamic>)
            .map((e) => CityData.fromJson(e))
            .toList();
        return right(cities);
      }
      return left(ServerFailure(data['error'] ?? 'Failed to load cities'));
    } catch (error) {
      log(error.toString());
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateMyCities({
    required int technicalUserId,
    required List<int> cityIds,
  }) async {
    try {
      final response = await DioHelper.putData(
        endPoint: EndPoints.updateTechnicalCities,
        data: {
          'technicalUserId': technicalUserId,
          'cityIds': cityIds,
        },
      );
      final data = response.data;
      if (data['isSuccess'] == true) {
        return right(true);
      }
      return left(ServerFailure(data['error'] ?? 'Failed to update cities'));
    } catch (error) {
      log(error.toString());
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }
}
