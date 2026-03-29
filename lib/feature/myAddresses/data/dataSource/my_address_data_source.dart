import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/feature/myAddresses/data/models/my_address_model.dart';

class MyAddressDataSource {
  static Future<Either<Failure, MyAddressModel>> getMyAddress({required BuildContext context}) async {
    try {
      final response = await DioHelper.getData(url: '${EndPoints.getMyAddress}${userCacheValue?.data?.userId}', context: context);

      log('response.data myAddress: ${response.data}');
      return right(MyAddressModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
