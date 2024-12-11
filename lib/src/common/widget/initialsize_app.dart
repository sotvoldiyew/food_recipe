import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_recipe/src/common/service/api_service.dart';
import 'package:food_recipe/src/feature/edit_profile/data/edit_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../dependency/dependency.dart';

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
        baseUrl: Constants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30)
      )
    );

    final apiService = ApiService(dio: dio);

    IEditRepository editRepository = EditRepositoryImpl(apiService: apiService);

    return AppDependency(
      locale: locale,
      shp: shp,
      theme: theme,
      editRepository: editRepository,
    );
  }
}