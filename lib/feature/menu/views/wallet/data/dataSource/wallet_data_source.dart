import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/errors/failures.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/feature/menu/views/wallet/data/model/transactions_model.dart';
import 'package:matlop_provider/feature/menu/views/wallet/data/model/wallet_model.dart';
import 'package:matlop_provider/feature/menu/views/wallet/data/model/wallet_params.dart';

abstract class WalletDataSourceAbstract {
  Future<Either<Failure, WalletModel>> getBalanceData();

  Future<Either<Failure, TransactionsModel>> getTransactions();

  Future<Either<Failure, String>> addWallet({required WalletParams params});
}

class WalletDataSource extends WalletDataSourceAbstract {
  @override
  Future<Either<Failure, TransactionsModel>> getTransactions() async {
    try {
      final response = await DioHelper.getData(url: '/wallets/${userCacheValue?.data?.userId}/transactions');
      return right(TransactionsModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WalletModel>> getBalanceData() async {
    try {
      final response = await DioHelper.getData(url: '/wallets/${userCacheValue?.data?.userId}/balance');
      return right(WalletModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addWallet({required WalletParams params}) async {
    try {
      await DioHelper.postData(endPoint: EndPoints.addWallet, data: params.toJson());
      return right('successfully_wallet_added'.tr());
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
