import 'package:food_recipe/src/common/service/api_service.dart';

abstract interface class IReviewRepository {
  Future<void> addReview(String recipeId, String review);
}

class ReviewRepositoryImpl implements IReviewRepository {
  final ApiService apiService;

  ReviewRepositoryImpl({required this.apiService});

  @override
  Future<void> addReview(String recipeId, String review) async {

  }

}