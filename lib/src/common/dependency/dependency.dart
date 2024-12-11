import 'package:food_recipe/src/feature/edit_profile/data/edit_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDependency {
  AppDependency({
    required this.locale,
    required this.shp,
    required this.theme,
    required this.editRepository,
  });

  String locale;
  bool theme;

  final SharedPreferences shp;

  IEditRepository editRepository;
}
