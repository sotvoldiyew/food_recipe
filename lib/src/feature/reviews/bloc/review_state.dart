part of 'review_bloc.dart';

class ReviewState extends Equatable {
  final Status status;
  final bool isCommented;
  final List<CommentModel> comments;

  const ReviewState({
    this.status = Status.initial,
    this.isCommented = false,
    this.comments = const [],
  });

  ReviewState copyWith({
    final Status? status,
    final bool? isCommented,
    final List<CommentModel>? comments,
  }) =>
      ReviewState(
        status: status ?? this.status,
        isCommented: isCommented ?? this.isCommented,
        comments: comments ?? this.comments,
      );

  @override
  List<Object?> get props => [
        status,
        isCommented,
        comments,
      ];
}
