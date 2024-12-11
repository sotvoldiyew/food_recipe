import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/src/feature/verification_code/data/verification_model.dart';

import '../../../common/constants/constants.dart';

class VerificationRepository {
  final Dio dio;

  VerificationRepository({required this.dio});

  Future<bool> verification(VerificationRequest request) async {
    try {
      final response = await dio.post(
        Urls.verification,
        data: request.toJson(),
      );

      log("Verification repo response statuscode ${response.statusCode} ");

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
