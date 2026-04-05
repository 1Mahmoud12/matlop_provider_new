// ignore_for_file: type_annotate_public_apis
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/main.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// ignore: avoid_classes_with_only_static_members
class DioHelper {
  static Dio? dio;

  // ignore: always_declare_return_types
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    dio!.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }

  // get data ====>>>
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    BuildContext? context,
  }) async {
    final String token = Constants.token;
    debugPrint('token: $token');
    dio!.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (Constants.selectedCountryId != null) 'X-Country-id': Constants.selectedCountryId,
    };
    return dio!
        .get(
      url,
      queryParameters: query,
    )
        .then(
      (value) {
        // if (value.data is Map && '${value.data['code']}' == '1') {
        //   throw value.data['message'];
        // }
        return value;
      },
    );
  }

  // post data ====>>>
  static Future<Response> postData({
    required String endPoint,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    bool formDataIsEnabled = false,
    BuildContext? context,
    CancelToken? cancelToken,
  }) async {
    final String token = Constants.token;

    debugPrint('token: $token');
    dio!.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (Constants.selectedCountryId != null) 'X-Country-id': Constants.selectedCountryId,
    };

    return dio!
        .post(
      '${EndPoints.baseUrl}$endPoint',
      queryParameters: query,
      data: formDataIsEnabled ? FormData.fromMap(data) : data,
      cancelToken: cancelToken,
    )
        .then((value) {
      printDM('Response post Method ==== \n $value');
      printDM('statusMessage ==> ${value.statusMessage}');
      if (context != null) {}
      if (value.data['status'] == false) {
        throw value.data['message'];
      }
      return value;
    });
  }

  // putData ====>>>
  static Future<Response> putData({
    required String endPoint,
    Map<String, dynamic>? query,
    bool formDataIsEnabled = false,
    required Map<String, dynamic> data,
  }) async {
    //final String token = HiveReuse.mainBox.get(AppConst.tokenBox) ?? '';
    final String token = Constants.token;

    dio!.options.headers = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      if (Constants.selectedCountryId != null) 'X-Country-id': Constants.selectedCountryId,
    };

    return dio!
        .put(
      endPoint,
      queryParameters: query,
      data: formDataIsEnabled ? json.encode(data) : data,
    )
        .then(
      (value) {
        return value;
      },
    );
  }

  // deleteData ====>>>
  static Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? query,
    bool formDataIsEnabled = false,
    required Map<String, dynamic> data,
  }) async {
    final String token = Constants.token;

    // final String token = HiveReuse.mainBox.get(AppConst.tokenBox) ?? '';
    dio!.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': '*/*',
      if (Constants.selectedCountryId != null) 'X-Country-id': Constants.selectedCountryId,
    };

    return dio!.delete(
      endPoint,
      queryParameters: query,
      data: formDataIsEnabled ? FormData.fromMap(data) : data,
    );
  }

  static Future<String> loadMockData({required String fileName, required BuildContext context}) async {
    final String filePath = 'assets/endpoints/$fileName.json';
    final String jsonString = await DefaultAssetBundle.of(context).loadString(filePath);
    return jsonString;
  }

  static Future<Map<String, dynamic>> makeNetworkRequest({required String endpoint, required BuildContext context}) async {
    final String mockData = await loadMockData(fileName: endpoint, context: context);
    // Parse the mock data into a JSON object
    final Map<String, dynamic> jsonData = json.decode(mockData);
    // Convert the JSON data into a model object or use it directly
    logger.i(jsonData.toString());
    return jsonData;
  }
}
