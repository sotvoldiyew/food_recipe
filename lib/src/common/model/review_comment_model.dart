import 'package:flutter/foundation.dart';
import 'package:food_recipe/src/common/model/comment_model.dart';

class ReviewCommentModel {
  int recipeId;
  int savedCount;
  int commentsCount;
  List<CommentModel> commentModel;

  ReviewCommentModel({
    required this.recipeId,
    required this.savedCount,
    required this.commentsCount,
    required this.commentModel,
  });

  factory ReviewCommentModel.fromJson(Map<String, dynamic> json) {
    return ReviewCommentModel(
      recipeId: json['recipeId'],
      savedCount: json['savedCount'],
      commentsCount: json['commentsCount'],
      commentModel: List.from(
        json['reviews'].map((e) => CommentModel.fromJson(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipeId': recipeId,
      'savedCount': savedCount,
      'commentsCount': commentsCount,
      'reviews': commentModel.map((e) => e.toJson()).toList(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewCommentModel &&
        other.recipeId == recipeId &&
        other.savedCount == savedCount &&
        other.commentsCount == commentsCount &&
        listEquals(other.commentModel, commentModel);
  }

  @override
  int get hashCode => Object.hashAll(
    [
      recipeId,
      savedCount,
      commentsCount,
      ...commentModel
    ]
  );

  @override
  String toString() {
    return 'ReviewCommentModel{recipeId: $recipeId, savedCount: $savedCount, commentsCount: $commentsCount, commentModel: $commentModel}';
  }
}
