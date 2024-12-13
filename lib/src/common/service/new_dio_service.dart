import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe/src/common/constants/constants.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';

@immutable
class NetworkService {
  const NetworkService._();

  static Future<Dio> initDio(BuildContext context) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        headers: await NetworkService.getHeaders(context: context),
        // connectTimeout: ApiConst.connectionTimeout,
        // receiveTimeout: ApiConst.sendTimeout,
        // sendTimeout: ApiConst.sendTimeout,
        validateStatus: (status) => status != null && status < 205,
      ),
    );

    // dio.interceptors.addAll([
    //   ConnectivityInterceptor(
    //     requestReceiver: Connection(
    //       dio: dio,
    //       connectivity: Connectivity(),
    //     ),
    //   ),
    //   LogInterceptor(
    //     requestBody: true,
    //     responseBody: true,
    //   ),
    // ]);

    // final adapter = dio.httpClientAdapter as IOHttpClientAdapter;
    // adapter.createHttpClient = () {
    //   final client = HttpClient();
    //   client.badCertificateCallback = (cert, host, port) => true; // Disable SSL validation for development
    //   return client;
    // };

    return dio;
  }

  static Map<String, String> getHeaders({bool isUpload = false, required BuildContext context}) {
    final headers = <String, String>{
      "Content-type": isUpload ? "multipart/form-data" : "application/json; charset=UTF-8",
      "Accept": isUpload ? "multipart/form-data" : "application/json; charset=UTF-8",
    };

    final token = context.dependencies.shp.getString('token') ?? "";

    if (token.isNotEmpty) {
      headers.putIfAbsent("Authorization", () => "Bearer $token");
    }

    return headers;
  }

  static Future<String?> get(String api, Map<String, Object> params, BuildContext context) async {
    final fullUrl = "${Constants.baseUrl}$api";
    log("Request URL: $fullUrl  \n Request Params: $params");
    try {
      final response = await (await initDio(context)).get<dynamic>(api, queryParameters: params);
      log("response status code = ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("response data == ${response.data}");
        return jsonEncode(response.data);
      }
    } on DioException catch (e) {
      log("DioException: Error at ${e.requestOptions.uri}. Because of ${e.type.name}");
    } catch (e) {
      log("Unexpected error: $e");
    }
    return null;
  }

  // static Future<dynamic> getData(String api, Map<String, dynamic> params) async {
  //   try {
  //     final fullUrl = "${Constants.baseUrl}$api"; log("Request URL: $fullUrl"); log("Request Params: $params");
  //
  //     final response = await (await initDio()).get<dynamic>(api, queryParameters: params);
  //     //
  //     // if (response.data is Map<String, dynamic> || response.data is List) {
  //     //   log("1");
  //     //   return response.data; // Return the raw Map or List data
  //     // }
  //     // if (response.data is String) {
  //     //   log("2");
  //     //   return response.data;
  //     // }
  //     // log("3");
  //
  //     return jsonEncode(response.data);
  //     // return response.data.toString();
  //   } on TimeoutException catch (_) {
  //     log("The connection has timed out, Please try again!");
  //     rethrow;
  //   } on DioException catch (e) {
  //     log("Error: ${e.response.toString()}");
  //     rethrow;
  //   } catch (e) {
  //     log("Error: ${e.toString()}");
  //     rethrow;
  //   }
  // }

  static Future<String?> postOneData({required String api, required String token, required String data}) async {
    log("token: $token \n");
    final newDio = Dio(BaseOptions(baseUrl: Constants.baseUrl, headers: {'Content-Type': 'text/plain', "Authorization": "Bearer $token"}));
    log("Url = ${Constants.baseUrl}$api");
    final response = await newDio.post(api, data: data);
    log("Response status code ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonEncode(response.data);
    } else {
      return null;
    }
  }

  static Future<String?> post(
      {required String api, required BuildContext context, required Map<String, Object?> data, Map<String, Object>? params = const {}}) async {
    try {
      log("try func in Post method");
      final response = await (await initDio(context)).post<dynamic>(api, data: data, queryParameters: params);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("response status code ${response.statusCode}");
        return jsonEncode(response.data);
      } else {
        return null;
      }
    } on TimeoutException catch (_) {
      log("The connection has timed out, Please try again!");
      rethrow;
    } on DioException catch (e) {
      log(e.response.toString());
      rethrow;
    } on Object catch (_) {
      rethrow;
    }
  }

//
// static Future<String?> put(String api, Map<String, dynamic> data) async {
//   try {
//     final response = await (await initDio()).put<dynamic>(api, data: data);
//
//     return jsonEncode(response.data);
//   } on TimeoutException catch (_) {
//     log("The connection has timed out, Please try again!");
//     rethrow;
//   } on DioException catch (e) {
//     log(e.response.toString());
//     rethrow;
//   } on Object catch (_) {
//     rethrow;
//   }
// }
//
// static Future<String?> delete(String api, Map<String, dynamic> params) async {
//   try {
//     final _ = await (await initDio()).delete<dynamic>(api, queryParameters: params);
//     return "success";
//   } on TimeoutException catch (_) {
//     log("The connection has timed out, Please try again!");
//     rethrow;
//   } on DioException catch (e) {
//     log(e.response.toString());
//     rethrow;
//   } on Object catch (_) {
//     rethrow;
//   }
// }

  static Future<String?> sendMultipartRequest(
      {required String api, required BuildContext context, required Map<String, dynamic> jsonData, required File file}) async {
    try {
      log("try");
      final fileData = await MultipartFile.fromFile(file.path, filename: file.path.split('/').last);
      final formData = FormData.fromMap({'json': jsonEncode(jsonData), 'file': fileData});

      final dio = Dio(BaseOptions(
        baseUrl: Constants.baseUrl,
        headers: getHeaders(isUpload: true, context: context),
        validateStatus: (status) => status! < 203,
      ));
      log("url == ${Constants.baseUrl}/$api");
      final response = await dio.post(api, data: formData);
      log("multipart status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        log('Yuborildi: ${response.data}');
        return jsonEncode(response.data);
      } else {
        log('Xatolik: Else state ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Xato yuz berdi: $e\n\ntry catch==> catch');
      return null;
    }
  }
}
