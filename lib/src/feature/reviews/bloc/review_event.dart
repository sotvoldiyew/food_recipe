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

final class Emoji$ReviewEvent extends ReviewEvent {
  final String emoji;
  final int id;

  const Emoji$ReviewEvent({
    required this.emoji,
    required this.id,
  });
}
