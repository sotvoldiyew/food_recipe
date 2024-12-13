import 'package:food_recipe/src/common/model/user_review_model.dart';

class CommentModel {
  int reviewId;
  UserReviewModel userReviewModel;
  String comment;
  int likeCount;
  int dislikeCount;
  bool? hasLikedUser;
  String createdAt;

  CommentModel({
    required this.reviewId,
    required this.userReviewModel,
    required this.comment,
    required this.likeCount,
    required this.dislikeCount,
    required this.hasLikedUser,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, Object?> json) {
    return CommentModel(
      reviewId: json['reviewId'] as int,
      userReviewModel: UserReviewModel.fromJson(json['userDtoReview'] as Map<String, Object?>),
      comment: json['comment'] as String,
      likeCount: json['likes_count'] as int,
      dislikeCount: json['dislikes_count'] as int,
      hasLikedUser: json['hasLikedUser'] as bool? ?? false,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'reviewId': reviewId,
      'userDtoReview': userReviewModel.toJson(),
      'comment': comment,
      'likes_count': likeCount,
      'dislikes_count': dislikeCount,
      'hasLikedUser': hasLikedUser,
      'created_at': createdAt,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is CommentModel &&
        other.reviewId == reviewId &&
        other.userReviewModel == userReviewModel &&
        other.comment == comment &&
        other.likeCount == likeCount &&
        other.dislikeCount == dislikeCount &&
        other.hasLikedUser == hasLikedUser &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => Object.hash(
    reviewId,
    userReviewModel,
    comment,
    likeCount,
    dislikeCount,
    hasLikedUser,
    createdAt,
  );

  @override
  String toString() {
    return 'CommentModel{reviewId: $reviewId, userReviewModel: $userReviewModel, comment: $comment, likeCount: $likeCount, dislikeCount: $dislikeCount, hasLikedUser: $hasLikedUser, createdAt: $createdAt}';
  }
}
