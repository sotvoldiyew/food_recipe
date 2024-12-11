import 'package:flutter/src/widgets/framework.dart';
import 'package:food_recipe/src/common/repository/app_repository.dart';

class AppRepositoryImplementation extends AppRepository{
  @override
  Future<bool> signIn({required Map<String, Object> userData,required BuildContext context}) async{
   return false;
  }

}