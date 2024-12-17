part of 'review_bloc.dart';

class ReviewState extends Equatable {
  final Status status;
  final bool? isCommented;
  final List<CommentModel> comments;
  final int recipeId;
  final int userId;

  const ReviewState({
    this.status = Status.initial,
    this.isCommented,
    this.comments = const [],
    this.recipeId = -1,
    this.userId = -1,
  });

  ReviewState copyWith({
    final Status? status,
    final bool? isCommented,
    final List<CommentModel>? comments,
    final int? recipeId,
    final int? userId,
  }) =>
      ReviewState(
        status: status ?? this.status,
        isCommented: isCommented ?? this.isCommented,
        comments: comments ?? this.comments,
        recipeId: recipeId ?? this.recipeId,
        userId: userId ?? this.userId,
      );

  @override
  List<Object?> get props => [
        status,
        isCommented,
        comments,
        recipeId,
        userId,
      ];
}
