class Constants{
  const Constants._();

  static const String locale = "locale";
  static const String theme = "theme";
  static const String token = "token";
}

class Urls {
  const Urls._();

  static const String baseUrl = 'http://95.130.227.21:8080/api';

  // Home Controller
  static const String newRecipes = "/home/new-recipes";
  static const String categories = "/home";
  static const String recipesByCategory = "/home/category";

  // Search Controller
  static const String search = "/search/result";
  static const String recentSearches = "/search";
}