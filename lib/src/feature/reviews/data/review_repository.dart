import 'dart:developer';

import 'package:food_recipe/src/common/model/review_comment_model.dart';
import 'package:food_recipe/src/common/service/api_service.dart';

import '../../../common/constants/constants.dart';

abstract interface class IReviewRepository {
  const IReviewRepository();

  Future<bool> sendComment({required int recipeId, required String comment});

  Future<ReviewCommentModel?> getReviews({required int recipeId});

  Future<bool> deleteComment({required int commentId});

  Future<bool> reactionToComment({required int reviewId, required int userId, required bool isLike});
}

class ReviewRepositoryImpl implements IReviewRepository {
  final ApiService apiService;

  ReviewRepositoryImpl({required this.apiService});

  @override
  Future<bool> sendComment({
    required int recipeId,
    required String comment,
  }) async {
    try {
      final response = (await apiService.request(
        Urls.addReview,
        method: Method.post,
        data: {
          "recipeId": recipeId,
          "comment": comment,
        },
      ));

      log("Response [addReview]: $response");

      return true;
    } on Object catch (e, s) {
      log('Error [addReview]: $e');
      log('Stacktrace [addReview]: $s');
      return false;
    }
  }

  @override
  Future<ReviewCommentModel?> getReviews({required int recipeId}) async {
    try {
      final response = (await apiService.request(
        "${Urls.getReviews}/$recipeId/0/20",
      ))['data'] as Map<String, Object?>;

      log("Response [getCommentsReview]: $response");

      return ReviewCommentModel.fromJson(response);
    } on Object catch (e, s) {
      log('Error [getCommentsReview]: $e');
      log('Stacktrace [getCommentsReview]: $s');
      return null;
    }
  }

  @override
  Future<bool> deleteComment({required int commentId}) async {
    try {
      final response = (await apiService.request(
          "${Urls.deleteComment}/$commentId/comment",
          method: Method.delete,
      ));

      log("Response [deleteComment]: $response");

      return true;
    } on Object catch (e, s) {
      log('Error [deleteComment]: $e');
      log('Stacktrace [deleteComment]: $s');
      return false;
    }
  }

  @override
  Future<bool> reactionToComment({
    required int reviewId,
    required int userId,
    required bool isLike,
  }) async {
    try {
      final response = (await apiService.request(
          Urls.addReaction,
          method: Method.post,
          data: {
            "reviewId": reviewId,
            "userId": userId,
            "hasLiked": isLike,
          }
      ))['data'] as Map<String, Object?>;

      log("Response [reactionToComment]: $response");

      return true;
    } on Object catch (e, s) {
      log('Error [reactionToComment]: $e');
      log('Stacktrace [reactionToComment]: $s');
      return false;
    }
  }
}
