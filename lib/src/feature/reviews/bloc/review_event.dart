part of 'review_bloc.dart';

sealed class ReviewEvent {
  const ReviewEvent();
}

final class SendMessage$ReviewEvent extends ReviewEvent {
  final BuildContext context;
  final String text;

  const SendMessage$ReviewEvent({
    required this.text,
    required this.context,
  });
}

final class DeleteComment$ReviewEvent extends ReviewEvent {
  final BuildContext context;
  final int commentId;

  const DeleteComment$ReviewEvent({
    required this.context,
    required this.commentId,
  });
}

final class Emoji$ReviewEvent extends ReviewEvent {
  final BuildContext context;
  final bool emoji;
  final int userId;
  final int reviewId;

  const Emoji$ReviewEvent({
    required this.context,
    required this.emoji,
    required this.userId,
    required this.reviewId,
  });
}

final class GetReviews$ReviewEvent extends ReviewEvent {
  final BuildContext context;
  final int recipeId;

  const GetReviews$ReviewEvent({
    required this.context,
    required this.recipeId,
  });
}
