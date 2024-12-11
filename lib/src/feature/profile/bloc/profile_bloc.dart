import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../common/utils/status_enum.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<ProfileEvent>((event, emit) => switch (event) {
          ViewMore$ProfileEvent() => _viewMore(event, emit),
      UpdateText$ProfileEvent() => _updateText(event, emit),
        });
  }

  void _viewMore(ViewMore$ProfileEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(status: Status.loading));
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: event.text, style: event.style),
      maxLines: 2,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: event.maxWidth);

    if (!textPainter.didExceedMaxLines) {
      emit(state.copyWith(status: Status.success, text: event.text));
    }

    int endIndex = textPainter
        .getPositionForOffset(
          Offset(textPainter.width, textPainter.height),
        )
        .offset;

    emit(
      state.copyWith(
        status: Status.success,
        text: event.text.substring(0, endIndex).trim(),
      ),
    );
  }
  void _updateText(UpdateText$ProfileEvent event, Emitter<ProfileState> emit){
    emit(state.copyWith(status: Status.loading));
    emit(state.copyWith(status: Status.success, isExpanded: !state.isExpanded));

  }
}
