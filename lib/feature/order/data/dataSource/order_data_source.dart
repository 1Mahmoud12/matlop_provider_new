import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/feature/order/data/models/get_order_details_model.dart';
import 'package:matlop_provider/feature/order/data/models/order_model.dart';
import 'package:matlop_provider/main.dart';

abstract class OrderDataSource {
  Future<Either<Failure, OrderModel>> getOrdersByStatus({required BuildContext context, required int? status});

  Future<Either<Failure, OrderDetailsModel>> getOrderDetails({required BuildContext context, required int orderId});

  Future<Either<Failure, String>> changeStatus({required int status, required int orderId});
}

class OrderDataSourceImpl extends OrderDataSource {
  @override
  Future<Either<Failure, OrderModel>> getOrdersByStatus({required BuildContext context, required int? status}) async {
    try {
      final response =
          //${userCacheValue?.data?.userId}
          await DioHelper.getData(
              url: '${EndPoints.getOrdersByStatus}/${userCacheValue?.data?.userId}',
              query: {if (status != null && (status == 7 || status == 8)) 'orderStatus': status},
              context: context);
      return right(OrderModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderDetailsModel>> getOrderDetails({required BuildContext context, required int orderId}) async {
    try {
      final response = await DioHelper.getData(url: '${EndPoints.getOrderDetails}$orderId', context: context);
      // logger.i(response.data);
      return right(OrderDetailsModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> changeStatus({required int status, required int orderId}) async {
    try {
      final response = await DioHelper.putData(
          endPoint: '${EndPoints.changeStatus}$orderId/status',
          query: {
            'orderStatusEnum': status,
          },
          data: {},
          formDataIsEnabled: true);

      if (response.data != null && response.data is Map<String, dynamic>) {
        if (response.data['isSuccess'] == false) {
          final errorMsg = response.data['error']?.toString() ?? response.data['message']?.toString() ?? 'Error changing status';
          return left(ServerFailure(errorMsg));
        } else {
          final msg = response.data['message']?.toString() ?? '';
          return right(msg.isNotEmpty ? msg : 'successfully_status_order_changed'.tr());
        }
      }

      return right('successfully_status_order_changed'.tr());
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
