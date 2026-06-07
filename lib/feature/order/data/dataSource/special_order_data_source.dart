import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/feature/order/data/models/details_special_order_model.dart';
import 'package:matlop_provider/feature/order/data/models/details_special_order_model.dart';
import 'package:matlop_provider/feature/order/data/models/special_orders_model.dart';

class SpecialOrderDataSource {
  static Future<Either<Failure, SpecialOrdersModel>> getSpecialOrdersByStatus({required BuildContext context, int? status,int? type}) async {
    try {
      final response =
          //${userCacheValue?.data?.userId}
          await DioHelper.getData(url: '${EndPoints.getSpecialOrdersByStatus}/${userCacheValue?.data?.userId}',query: {
            if(status!=null)'orderStatus':status, if(type!=null)'specialOrderEnum':type
          }, context: context);
      return right(SpecialOrdersModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  static Future<Either<Failure, DetailsSpecialOrderModel>> getSpecialOrderDetails({required BuildContext context, required int orderId}) async {
    try {
      final response = await DioHelper.getData(url: '${EndPoints.getSpecialOrderDetails}/$orderId', context: context);
      return right(DetailsSpecialOrderModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  static Future<Either<Failure, String>> changeStatus({required int status, required int orderId}) async {
    try {
      final response = await DioHelper.putData(
          endPoint: '${EndPoints.getSpecialOrderDetails}/$orderId/status',
          query: {
            'specialOrderStatusEnum': status,
          },
          data: {},
          formDataIsEnabled: true);

      if (response.data != null && response.data is Map<String, dynamic>) {
        if (response.data['isSuccess'] == false) {
          final errorMsg = response.data['error']?.toString() ?? response.data['message']?.toString() ?? 'Error changing status';
          return left(ServerFailure(errorMsg));
        } else {
          final msg = response.data['message']?.toString() ?? '';
          return right(msg.isNotEmpty ? msg : 'Successfully changed status');
        }
      }

      return right('Successfully changed status');
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
