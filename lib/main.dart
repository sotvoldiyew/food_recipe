import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/widget/app.dart';
import 'package:food_recipe/src/common/widget/initialsize_app.dart';
import 'package:food_recipe/src/common/widget/my_appp_scope.dart';
void main() async {
  final dependency = await InitializeApp().initialize();
  runApp(
    MyAppScope(
      dependency: dependency,
      child: const MyApp(),
    ),
  );
}