import 'package:dio/dio.dart';
import 'package:food_recipe/src/common/constants/constants.dart';

class OwnerRepository {
  final Dio _dio = Dio();

  Future<void> getUserById(int userId) async {
    try {
      final response = await _dio.get(
        Constants.baseUrl + Urls.owner,
        queryParameters: {
          'userId': userId,
        },
      );

      if (response.statusCode == 200) {
        print('User data: ${response.data}');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during request: $e');
    }
  }
}
