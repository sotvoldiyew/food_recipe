import 'package:dio/dio.dart';
import 'package:food_recipe/src/feature/main/data/main_repository.dart';
import 'package:food_recipe/src/feature/reviews/data/review_repository.dart';
import 'package:food_recipe/src/feature/search/data/search_repository.dart';
import 'package:food_recipe/src/feature/edit_profile/data/edit_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDependency {
  AppDependency({
    required this.locale,
    required this.shp,
    required this.theme,
    required this.editRepository,
    required this.dio,
    required this.reviewRepository,
    required this.mainRepository,
    required this.searchRepository,
  });

  String locale;
  bool theme;

  final SharedPreferences shp;
  final Dio dio;

  IEditRepository editRepository;
  final IReviewRepository reviewRepository;
  final IMainRepository mainRepository;
  final ISearchRepository searchRepository;
}
