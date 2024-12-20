import 'package:dio/dio.dart';
import 'package:food_recipe/src/common/constants/constants.dart';

class FollowRepository {
  final Dio _dio = Dio(
      BaseOptions(baseUrl: Constants.baseUrl)
  );

  Future<void> follow(int userId, String token) async {
    try {
      final response = await _dio.post(
        Urls.follow,
        data: {
          'id': userId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('follow successfully');
      } else {
        print('Failed to follow: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
   Future<void> unFollow(int userId, String token) async {
    try {
      final response = await _dio.post(
        Urls.unFollow,
        data: {
          'id': userId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('follow successfully');
      } else {
        print('Failed to follow: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

 Future<void> rate(int recipeId, String token, Object rate) async {
    try {
      final response = await _dio.post(
        Urls.unFollow,
        data: {
          "comment" : "string",
          "rating": recipeId,
          "recipeId": rate
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('follow successfully');
      } else {
        print('Failed to follow: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

}
