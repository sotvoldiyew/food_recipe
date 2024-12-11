import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/src/feature/profile/data/profile_model.dart';

import '../../../common/constants/constants.dart';

class ProfileRepository {
  final Future<Map<String, String>> Function() getHeaders;
  final Dio dio;

  ProfileRepository({required this.getHeaders, Dio? dio})
      : dio = dio ?? Dio();

  Future<UserProfile?> fetchUserProfile() async {
    try {
      final headers = await getHeaders();
      final response = await dio.get(
        Urls.myProfile,
        options: Options(headers: headers),
      );
      if (headers['Authorization'] == null || headers['Authorization']!.isEmpty) {
        throw Exception("Authorization token is missing!");
      }

      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          return UserProfile.fromJson(response.data);
        } else {
          debugPrint('Error: ${response.data['text']}');
        }
      } else {
        debugPrint('Failed to load user profile: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e, stackTrace) {

      debugPrint('Error occurred while fetching user profile: $e');
      debugPrint('StackTrace: $stackTrace');
    }
    return null;
  }
}
