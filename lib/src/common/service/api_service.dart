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
    final sw = Stopwatch()..start();
    if (!await checkConnection()) throw Exception("No Connection");

    try {
      const token = 'eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzM4MDQ3OTcsInN1YiI6InNheWR1bGxhMjQxMEBnbWFpbC5jb20iLCJleHAiOjE3MzYzOTY3OTd9.eUU0FhR8M5vZoPdT3zOttr7t5SfR9lFNryws6-UD35Y';

      final requestHeaders = {
        ...?headers,
        'Authorization': 'Bearer $token',
        'content-Type': formData != null ? 'multipart/form-data' : 'application/json',
      };

      final response = await dio.request<Map<String, Object?>?>(path,
          data: data ?? formData,
          queryParameters: queryParams,
          options: Options(
            method: method.name,
            headers: requestHeaders,
          ));

      log("Response Data: $response");

      if (response.statusCode == null ||
          response.statusCode! > 204 ||
          response.data == null) {
        throw Exception('API Error');
      }

      return response.data ?? <String, Object?>{};
    } on Object catch (_) {
      rethrow;
    } finally {
      debugPrint('TIME FOR API -> ${(sw..stop()).elapsedMilliseconds} ms');
    }
  }
}
