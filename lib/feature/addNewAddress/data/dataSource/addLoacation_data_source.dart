import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/add_location_parameter.dart';

class AddLocationDataSource {
  static Future<Either<Failure, String>> postLocation({required BuildContext context, required LocationParameter locationParameters}) async {
    try {
      final response = await DioHelper.postData(endPoint: EndPoints.postLocation, data: locationParameters.toJson(), context: context);
      log('test city endpoint${response.data}');
      return right('Order Add Successfully');
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
