import 'package:dio/dio.dart';
import 'package:matlop_provider/main.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioException(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');
      case DioExceptionType.badResponse:
        logger.e('badResponse on url ${dioError.response!.realUri}');
        logger.e('badResponse on my data ${dioError.response!.statusCode}');
        logger.e('badResponse on my data ${dioError.response}');
        return ServerFailure.fromResponse(dioError.response!.statusCode, dioError.response!.data);
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad Certificate with ApiServer');
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection');

      case DioExceptionType.unknown:
        return ServerFailure('Unexpected Error, Please try again!');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 401 || statusCode == 422 || statusCode == 400 || statusCode == 404 || statusCode == 409) {
      logger.e('message $response');

      if (response is Map<String, dynamic>) {
        final error = response['error'];
        final message = response['message'];
        if (error != null && error is String && error.isNotEmpty) {
          return ServerFailure(error);
        } else if (message != null && message is String && message.isNotEmpty) {
          return ServerFailure(message);
        }
      }

      if (statusCode == 404) {
        return ServerFailure('Your request not found, Please try later!');
      }
      return ServerFailure('Something went wrong, Please try again');
    } else if (statusCode == 500) {
      //  logger.e('object::>> $response');
      return ServerFailure('Internal Server error, Please try later');
    } else {
      return ServerFailure('Opps There was an Error, Please try again');
    }
  }
}
