import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:food_recipe/src/common/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_recipe/src/feature/ingredient/data/recipe_model.dart';

class RecipeRepository {
  final Dio _dio = Dio();

   Future<RecipeInfo?> fetchRecipeInfoById( int id) async {
     log("repository function  fetchRecipeInfoById");

    final String url = '${Constants.baseUrl}/recipeM/$id';
    log("url  => $url");

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        print('Token not found');
        return null;
      }

      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      log("responce status code ${response.statusCode}");

      if (response.statusCode == 200) {
        return RecipeInfo.fromJson(response.data);
      } else {
        print('Server error: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      print('Request error: ${e.message}');
      return null;
    }
  }
}
