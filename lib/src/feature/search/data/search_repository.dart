import 'dart:developer';

import 'package:food_recipe/src/common/model/search_model.dart';
import 'package:food_recipe/src/common/service/api_service.dart';

import '../../../common/constants/constants.dart';

abstract interface class ISearchRepository {
  ISearchRepository();

  Future<List<SearchModel>> searchRecipes({required String query});

  Future<List<SearchModel>> recentRecipes({required int userId});

  Future<bool> addRecentRecipe({required int id});

  Future<int> getUserId();
}

class SearchRepositoryImpl implements ISearchRepository {
  final ApiService apiService;

  SearchRepositoryImpl({required this.apiService});

  @override
  Future<List<SearchModel>> searchRecipes({required String query}) async {
    try {
      final response = (await apiService.request(
        Urls.search,
        method: Method.post,
        data: {
          "title": query,
        },
        queryParams: {
          "size": 10,
          "page": 0
        }
      ))['data'] as List;

      log("Response [getSearchRecipes]: $response");

      return List<Map<String, Object?>>.from(response)
          .whereType<Map<String, Object?>>()
          .map(SearchModel.fromJson)
          .toList();
    } on Object catch (e, s) {
      log('Error [gatSearchRecipes]: $e');
      log('Stacktrace [getSearchRecipes]: $s');
      return [];
    }
  }

  @override
  Future<List<SearchModel>> recentRecipes({required int userId}) async {
    try {
      final response = (await apiService.request(
        Urls.recentSearches,
        queryParams: {
          "userId": userId,
          "size": 20,
          "page": 0
        },
      ))['data'] as List;

      log("Response [getCategories]: $response");

      return List<Map<String, Object?>>.from(response)
          .whereType<Map<String, Object?>>()
          .map(SearchModel.fromJson)
          .toList();
    } on Object catch (e, s) {
      log('Error [gatSearchRecipes]: $e');
      log('Stacktrace [getSearchRecipes]: $s');
      return [];
    }
  }

  @override
  Future<bool> addRecentRecipe({required int id}) async {
    try {
      final response = (await apiService.request(
        "${Urls.addRecentSearch}/$id",
      ));

      log("Response [addRecentSearch]: $response");

      return true;
    } on Object catch (e, s) {
      log('Error [addRecentSearch]: $e');
      log('Stacktrace [addRecentSearch]: $s');
      return false;
    }
  }

  @override
  Future<int> getUserId() async {
    try {
      final response = (await apiService.request(
        Urls.userProfile,
      ))['data'] as Map<String, Object?>;

      log("Response [getUserId]: $response");

      return response['userId'] as int;
    } on Object catch (e, s) {
      log('Error [getUserId]: $e');
      log('Stacktrace [getUserId]: $s');
      return -1;
    }
  }
}