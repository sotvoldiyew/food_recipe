import 'dart:developer';

import 'package:food_recipe/src/common/model/category_model.dart';
import 'package:food_recipe/src/common/model/recipe_model.dart';
import 'package:food_recipe/src/common/service/api_service.dart';

import '../../../common/constants/constants.dart';

abstract interface class IMainRepository {
  const IMainRepository();

  Future<List<RecipeModel>> getRecipes({Map<String, Object?>? data});

  Future<List<CategoryModel>> getCategories();

  Future<List<RecipeModel>> getRecipeByCategory({
    required int id,
    Map<String, Object?>? data,
  });
}

class MainRepositoryImpl implements IMainRepository {
  final ApiService apiService;

  MainRepositoryImpl({required this.apiService});

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = (await apiService.request(
        Urls.categories,
        data: {
          "id": 1,
          "size": 10,
          "page": 0
        },
      ))['data'] as Map<String, Object?>;

      log("Response [getCategories]: $response");

      return List<Map<String, Object?>>.from(response['categories'] as List)
          .whereType<Map<String, Object?>>()
          .map(CategoryModel.fromJson)
          .toList();
    } on Object catch (e, s) {
      log('Error [getCategories]: $e');
      log('Stacktrace [getCategories]: $s');
      return [];
    }
  }

  @override
  Future<List<RecipeModel>> getRecipes({
    Map<String, Object?>? data,
  }) async {
    try {
      final response = await apiService.request(
        Urls.newRecipes,
        queryParams: data,
      );

      log("Response [getRecipes]: $response");

      return List<Map<String, Object?>>.from(response['data'] as List)
          .whereType<Map<String, Object?>>()
          .map(RecipeModel.fromJson)
          .toList();
    } on Object catch (e, s) {
      log('Error [getRecipes]: $e');
      log('Stacktrace [getRecipes]: $s');
      return [];
    }
  }

  @override
  Future<List<RecipeModel>> getRecipeByCategory({
    required int id,
    Map<String, Object?>? data,
  }) async {
    try {
      final response = await apiService.request(
        "${Urls.recipesByCategory}/$id/recipes",
        queryParams: data,
      );

      log("Response [getRecipeByCategory]: $response");

      return List<Map<String, Object?>>.from(response['data'] as List)
          .whereType<Map<String, Object?>>()
          .map(RecipeModel.fromJson)
          .toList();
    } on Object catch (e, s) {
      log('Error [getRecipes]: $e');
      log('Stacktrace [getRecipes]: $s');
      return [];
    }
  }
}
