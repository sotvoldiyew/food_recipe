import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe/src/common/model/comment_model.dart';

import '../../../common/utils/status_enum.dart';

part 'review_state.dart';
part 'review_event.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(const ReviewState()) {
    on<ReviewEvent>(
      (event, emit) => switch (event) {
        SendMessage$ReviewEvent _ => _sendMessage(event, emit),
        Emoji$ReviewEvent _ => _emoji(event, emit),
      },
    );
  }

  Future<void> _sendMessage(
    SendMessage$ReviewEvent event,
    Emitter<ReviewState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));


    emit(state.copyWith(
      status: Status.success,
      comments: [],
      isCommented: true,
    ));
  }

  Future<void> _emoji(
    Emoji$ReviewEvent event,
    Emitter<ReviewState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    emit(state.copyWith(status: Status.success));
  }
}
