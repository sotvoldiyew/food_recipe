import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_recipe/src/feature/reviews/data/review_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/main/data/main_repository.dart';
import '../../feature/search/data/search_repository.dart';
import '../constants/constants.dart';
import '../dependency/dependency.dart';
import '../service/api_service.dart';

class InitializeApp {
  Future<AppDependency> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    final shp = await SharedPreferences.getInstance();

    bool theme = shp.getBool(Constants.theme) ?? true;
    String locale = shp.getString(Constants.locale) ?? "en";

    final dio = Dio(
      BaseOptions(
        baseUrl: Urls.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      )
    );

    final apiService = ApiService(dio: dio);

    /// Repositories
    final reviewRepository = ReviewRepositoryImpl(apiService: apiService);
    final mainRepository = MainRepositoryImpl(apiService: apiService);
    final searchRepository = SearchRepositoryImpl(apiService: apiService);

    return AppDependency(
      locale: locale,
      shp: shp,
      theme: theme,
      dio: dio,
      reviewRepository: reviewRepository,
      mainRepository: mainRepository,
      searchRepository: searchRepository,
    );
  }
}