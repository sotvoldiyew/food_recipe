import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe/src/common/model/comment_model.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';

import '../../../common/utils/status_enum.dart';

part 'review_state.dart';

part 'review_event.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(const ReviewState()) {
    on<ReviewEvent>(
      (event, emit) => switch (event) {
        SendMessage$ReviewEvent _ => _sendMessage(event, emit),
        Emoji$ReviewEvent _ => _emoji(event, emit),
        GetReviews$ReviewEvent _ => _getReviews(event, emit),
        DeleteComment$ReviewEvent _ => _deleteComment(event, emit),
      },
    );
  }

  Future<void> _sendMessage(
    SendMessage$ReviewEvent event,
    Emitter<ReviewState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    final response = await event.context.dependencies.reviewRepository.sendComment(
      recipeId: 1,
      comment: event.text,
    );

    log("Response [sendComment]: $response");

    final comments = await event.context.dependencies.reviewRepository.getReviews(
      recipeId: 1,
    );

    log("Response [getComments]: $comments");

    if (comments != null) {
      final commentList = comments.commentModel.reversed.toList();

      emit(state.copyWith(
        status: Status.success,
        comments: commentList,
      ));
    } else {
      emit(state.copyWith(
        status: Status.success,
        comments: [],
      ));
    }
  }

  Future<void> _emoji(
    Emoji$ReviewEvent event,
    Emitter<ReviewState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    final response = await event.context.dependencies.reviewRepository.reactionToComment(
      userId: event.userId,
      isLike: event.emoji,
      reviewId: event.reviewId,
    );

    log("Response [reactionToComment]: $response");

    final comments = await event.context.dependencies.reviewRepository.getReviews(
      recipeId: 1,
    );

    log("Response [getComments]: $comments");

    if (comments != null) {
      final commentList = comments.commentModel.reversed.toList();

      emit(state.copyWith(
        status: Status.success,
        comments: commentList,
      ));
    } else {
      emit(state.copyWith(
        status: Status.success,
        comments: [],
      ));
    }
  }

  Future<void> _getReviews(
    GetReviews$ReviewEvent event,
    Emitter<ReviewState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    final response = await event.context.dependencies.reviewRepository.getReviews(
      recipeId: event.recipeId,
    );

    final userId = await event.context.dependencies.reviewRepository.getUserId();

    log("Response [getReviews]: $response");
    log("Response [getUserId]: $userId");

    if (response != null) {
      final commentList = response.commentModel.reversed.toList();

      emit(state.copyWith(
        status: Status.success,
        comments: commentList,
        recipeId: response.recipeId,
        userId: userId,
      ));
    } else {
      emit(state.copyWith(
        status: Status.success,
        comments: [],
        recipeId: -1,
        userId: -1,
      ));
    }
  }

  Future<void> _deleteComment(
    DeleteComment$ReviewEvent event,
    Emitter<ReviewState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    final response = await event.context.dependencies.reviewRepository.deleteComment(
      commentId: event.commentId,
    );

    log("Response [deleteComment]: $response");

    final comments = await event.context.dependencies.reviewRepository.getReviews(
      recipeId: 1,
    );

    log("Response [getComments]: $comments");

    if (comments != null) {
      final commentList = comments.commentModel.reversed.toList();

      emit(state.copyWith(
        status: Status.success,
        comments: commentList,
      ));
    } else {
      emit(state.copyWith(
        status: Status.success,
        comments: [],
      ));
    }
  }
}
