// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:matlop_provider/core/network/dio_helper.dart';
// import 'package:matlop_provider/core/network/end_points.dart';
// import 'package:matlop_provider/core/network/errors/failures.dart';

// class DeleteAccountDataSource {
//   static Future<Either<Failure, String>> deleteAccount({
//     required BuildContext context,
//   }) async {
//     try {
//       final response = await DioHelper.deleteData(
//         endPoint: '${EndPoints.deleteAccount}${userCacheValue?.data?.userId ?? -1}',
//         data: {},
//       );
//       return right(response.data['message']);
//     } catch (e) {
//       if (e is DioException) {
//         return left(ServerFailure.fromDioException(e));
//       }
//       return left(ServerFailure(e.toString()));
//     }
//   }
// }
