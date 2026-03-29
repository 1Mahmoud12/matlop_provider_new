import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';

import '../../../../core/network/errors/failures.dart';
import '../../../../main.dart';
import '../models/firebase_params.dart';

abstract class MainDataSource {
  Future<Either<Failure, String>> setFirebase({required FirebaseParams params});
}

class MainDataSourceImpl extends MainDataSource {
  @override
  Future<Either<Failure, String>> setFirebase({required FirebaseParams params}) async {
    try {
      await DioHelper.postData(endPoint: EndPoints.setFirebaseToken, data: params.toJson());
      logger.i('Successfully Updated Firebase');
      // Utils.showToast(title: 'Successfully Updated Firebase', state: UtilState.success);
      return right('Successfully Updated');
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
