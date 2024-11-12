
import 'package:shared_preferences/shared_preferences.dart';


class AppDependency {
  AppDependency({
    required this.locale,
    required this.shp,
    required this.theme,
  });

  String locale;
  bool theme;

  final SharedPreferences shp;

}
