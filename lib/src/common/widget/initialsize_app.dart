import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    bool theme = shp.getBool(Constants.theme) ?? false;
    String locale = shp.getString(Constants.locale) ?? "en";




    return AppDependency(
      locale: locale,
      shp: shp,
      theme: theme,
    );
  }
}