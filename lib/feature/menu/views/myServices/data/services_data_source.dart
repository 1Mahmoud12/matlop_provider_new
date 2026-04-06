import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/feature/menu/views/myServices/data/models/technical_service_model.dart';

abstract class ServicesDataSourceInterface {
  /// Returns all available services from /api/technicals/technicalservices
  Future<Either<Failure, List<TechnicalServiceData>>> getAllServices();

  /// Updates the technical's selected services via PUT /api/technicals/services
  Future<Either<Failure, bool>> updateMyServices({
    required int technicalUserId,
    required List<int> serviceIds,
  });
}

class ServicesDataSource extends ServicesDataSourceInterface {
  @override
  Future<Either<Failure, List<TechnicalServiceData>>> getAllServices() async {
    try {
      final response = await DioHelper.getData(url: EndPoints.getTechnicalServices);
      final data = response.data;
      if (data['isSuccess'] == true) {
        final List<dynamic> rawList = data['data'];
        final Map<int, TechnicalServiceData> uniqueServices = {};
        
        for (var item in rawList) {
          final service = TechnicalServiceData.fromJson(item);
          // Only add if not already added to ensure uniqueness by serviceId
          if (!uniqueServices.containsKey(service.serviceId)) {
            uniqueServices[service.serviceId] = service;
          }
        }
        
        return right(uniqueServices.values.toList());
      }
      return left(ServerFailure(data['error'] ?? 'Failed to load services'));
    } catch (error) {
      log(error.toString());
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateMyServices({
    required int technicalUserId,
    required List<int> serviceIds,
  }) async {
    try {
      final response = await DioHelper.putData(
        endPoint: EndPoints.updateTechnicalServices,
        data: {
          'technicalUserId': technicalUserId,
          'serviceIds': serviceIds,
        },
      );
      final data = response.data;
      if (data['isSuccess'] == true) {
        return right(true);
      }
      return left(ServerFailure(data['error'] ?? 'Failed to update services'));
    } catch (error) {
      log(error.toString());
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }
}
