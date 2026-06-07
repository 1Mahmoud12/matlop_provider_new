// ignore_for_file: type_annotate_public_apis
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/main.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/auth/login/presentation/manager/cubit/login_cubit.dart';
import 'package:matlop_provider/feature/auth/login/presentation/login_view.dart';
import 'package:matlop_provider/core/network/local/cache.dart';

// ignore: avoid_classes_with_only_static_members
class DioHelper {
  static Dio? dio;
  static bool _isRefreshing = false;

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
    
    dio?.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException err, ErrorInterceptorHandler handler) async {
          final statusCode = err.response?.statusCode;

          // Only intercept 401, and only once (no infinite refresh loop)
          if (statusCode == 401 && !_isRefreshing) {
            final accessToken = Constants.token;
            final refreshToken = Constants.refreshToken;

            // Nothing to refresh with if tokens are empty (logged-out state)
            if (accessToken.isEmpty) {
              return handler.next(err);
            }

            _isRefreshing = true;
            try {
              // Separate Dio to avoid triggering this interceptor recursively
              final refreshDio = Dio();
              final refreshResponse = await refreshDio.post(
                '${EndPoints.baseUrl}${EndPoints.refreshToken}',
                options: Options(
                  headers: {
                    'Authorization': 'Bearer $accessToken',
                    'accept': '*/*',
                    'Content-Type': 'application/json',
                    'culture': Constants.currentLanguage,
                    'ui-culture': Constants.currentLanguage,
                    if (Constants.selectedCountryId != null) 'X-Country-id': Constants.selectedCountryId,
                  },
                ),
                data: {
                  'accessToken': accessToken,
                  'refreshToken': refreshToken,
                },
              );

              final data = refreshResponse.data;
              final newAccess = data['data']?['accessToken'] ?? data['accessToken'] ?? '';
              final newRefresh = data['data']?['refreshToken'] ?? data['refreshToken'] ?? '';

              if (newAccess.isEmpty) {
                throw Exception('Empty access token in refresh response');
              }

              // Persist new tokens in memory
              Constants.token = newAccess;
              Constants.refreshToken = newRefresh;

              // Persist to Hive cache so tokens survive a restart
              if (userCacheValue?.data != null) {
                userCacheValue!.data!.accessToken = newAccess;
                userCacheValue!.data!.refreshToken = newRefresh;
                await userCache?.put(userCacheKey, jsonEncode(userCacheValue!.toJson()));
              }

              logger.i('[Token Refresh] ✅ Token refreshed successfully.');

              // Retry the original failed request with the new token
              final opts = err.requestOptions;
              opts.headers['Authorization'] = 'Bearer $newAccess';

              final retryResponse = await dio!.request(
                opts.path,
                options: Options(
                  method: opts.method,
                  headers: opts.headers,
                ),
                data: opts.data,
                queryParameters: opts.queryParameters,
              );

              return handler.resolve(retryResponse);
            } catch (e) {
              logger.e('[Token Refresh] ❌ Refresh failed: $e');
              // Clear tokens so further 401s don't loop
              Constants.token = '';
              Constants.refreshToken = '';

              userCacheValue = null;
              userCache?.put(userCacheKey, '{}');

              // Force navigation to Login screen
              if (navigatorKey.currentContext != null) {
                navigatorKey.currentContext!.navigateToPageWithClearStack(
                  BlocProvider(create: (_) => LoginCubit(), child: const LoginView()),
                );
              }
            } finally {
              _isRefreshing = false;
            }
          }

          return handler.next(err);
        },
      ),
    );
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
