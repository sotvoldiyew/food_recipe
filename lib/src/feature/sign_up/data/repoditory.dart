
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe/src/common/constants/constants.dart';

import 'model.dart';

class AuthRepository {
  final Dio dio;

  AuthRepository({required this.dio});

  Future<bool> signUp(SignUpRequest request) async {
    try {
      final response = await dio.post(
        Urls.singUp,
        data: request.toJson(),
      );

      log("Auth repo response statuscode ${response.statusCode} ");

      if (response.statusCode == 200 && response.data['status'] == true) {
        debugPrint("Sign up success: ${response.data}");
        return true;
      } else {
        debugPrint("Sign up failed: ${response.data}");
        return false;
      }
    } catch (e) {
      debugPrint("Sign up error: $e");
      return false;
    }
  }
}
