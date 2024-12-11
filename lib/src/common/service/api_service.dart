import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

enum Method {
  get,
  put,
  post,
  delete,
}

class ApiService {
  const ApiService({required this.dio});

  final Dio dio;

  Future<bool> checkConnection() async {
    final connectivity = await (Connectivity().checkConnectivity());
    if (connectivity.contains(ConnectivityResult.mobile) ||
        connectivity.contains(ConnectivityResult.wifi)) return true;
    return false;
  }

  Future<Map<String, Object?>> request(
    String path, {
    Method method = Method.get,
    bool setToken = true,
    Object? data,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
    FormData? formData,
  }) async {
    log("Api service func is start to work");
    final sw = Stopwatch()..start();
    if (!await checkConnection()) throw Exception("No Connection");

    try {
      log("Api service func is Try func start to work");
      final requestHeaders = {
        ...?headers,
        'content-Type': formData != null ? 'multipart/form-data' : 'application/json',
      };

      log("Api service request func");
      final response = await dio.request<Map<String, Object?>?>(
        path,
        data: data ?? formData,
        queryParameters: queryParams,
        options: Options(
          method: method.name,
          headers: requestHeaders,
        ),
      );

      log("response status code ${response.statusCode}");

      if (response.statusCode == null ||
          response.statusCode! > 204 ||
          response.data == null) {
        throw Exception('API Error');
      }

      return response.data ?? <String, Object?>{};
    } on Object catch (_) {
      log("Api service try func on method ");
      rethrow;
    } finally {
      debugPrint('TIME FOR API -> ${(sw..stop()).elapsedMilliseconds} ms');
    }
  }
}
