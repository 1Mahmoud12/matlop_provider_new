// import 'dart:developer';

// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:user_workers/core/network/dio_helper.dart';
// import 'package:user_workers/core/network/errors/failures.dart';

// class StoreMessageDataSource {
//   static Future<Either<Failure, String>> storeMessage({
//     required String message,
//     required String email,
//     required String uuid,
//     required BuildContext context,
//     required String endpoint,
//   }) async {
//     final response = await DioHelper.postData(
//       endPoint: endpoint,
//       data: {
//         'body': message,
//         'uuid': uuid,
//         'email': email,
//       },
//       context: context,
//     );
//     log('response data type ${response.data.runtimeType}');
//     try {
//       log('store message response ${response.data}');

//       if (response.data.isEmpty) {
//         return left(ServerFailure('json data is empty'));
//       }
//       //final loadMessageModel = MessageModel.fromJson(response.data);

//       return right('success');
//     } catch (error) {
//       if (error is DioException) {
//         return left(ServerFailure.fromDioException(error));
//       }
//       return left(ServerFailure(error.toString()));
//     }
//   }
// }
