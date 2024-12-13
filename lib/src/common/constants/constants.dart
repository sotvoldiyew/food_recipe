class Constants{
  const Constants._();

  static const String locale = "locale";
  static const String theme = "theme";
  static const String token = "token";

  static const String baseUrl = "http://95.130.227.21:8080/api";

}

class Urls{
  const Urls._();

  static const String singIn = '/auth/sign-in';
  static const String singUp = '/auth/sign-up';
  static const String verification = '/auth/verify';
  static const String myProfile = '/user/my-profile';
  static const String user = '/user';
  static const String profileContent = '/user/profile-content';
  static const String savedRecipe = '/saved-recipes';
  static const String addOneRecipe = '/recipeM/addOne';
  static const String getAllIngredients = '/recipeA/ingredient';
  static const String requestPasswordReset = '/auth/request-password-reset';
  static const String refreshPassword = '/auth/reset-password';


  static Map<String, Object> profileContentParam({required int id, required int size}){
    Map<String, Object> map ={
      "userId":id,
      "page": 0,
      "size": size
    };
    return map;
  }
  static Map<String, Object> savedProductParam({required int size}){
    Map<String, Object> map ={
      "page": 0,
      "size": size
    };
    return map;
  }





}