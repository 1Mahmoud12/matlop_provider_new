import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/feature/order/data/models/details_special_order_model.dart';
import 'package:matlop_provider/feature/order/data/models/special_orders_model.dart';

class OffersOrderDataSource {
  static Future<Either<Failure, SpecialOrdersModel>> getOffersOrdersByStatus({required BuildContext context, int? status, int? type}) async {
    try {
      final response =
          //${userCacheValue?.data?.userId}
          await DioHelper.getData(
              url: EndPoints.getNewSpecialOrder,
              query: {if (status != null) 'OrderStatus': status, if (type != null) 'OffersOrderEnum': type},
              context: context);
      final result = SpecialOrdersModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  static Future<Either<Failure, DetailsSpecialOrderModel>> getOffersOrderDetails({required BuildContext context, required int orderId}) async {
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

  static Future<Either<Failure, String>> createSpecialOrderOffer(
      {required BuildContext context, required int specialOrderId, required num price}) async {
    try {
      await DioHelper.postData(endPoint: EndPoints.createSpecialOrderOffer, data: {
        "technicalId": userCacheValue?.data?.userId,
        "specialOrderId": specialOrderId,
        "price": price,
      });
      return right('Send Offer Successfully'.tr());
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
