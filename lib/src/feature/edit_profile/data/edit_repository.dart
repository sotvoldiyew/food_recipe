import 'dart:developer';
import 'package:food_recipe/src/common/constants/constants.dart';
import 'package:food_recipe/src/common/service/api_service.dart';

abstract interface class IEditRepository {
  IEditRepository();

    Future<bool> editProfile({required Map<String, Object?> data});
}

class EditRepositoryImpl implements IEditRepository {
  final ApiService apiService;

  EditRepositoryImpl({required this.apiService});


  @override
  Future<bool> editProfile({required Map<String, Object?> data}) async {

    final response = await apiService.request(
      Urls.user,
      data: data,
    );

    log("Response data: $response");

    return true;
  }

}