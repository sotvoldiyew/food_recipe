import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/utils/status_enum.dart';

part 'ingrident_event.dart';

part 'ingrident_state.dart';

class IngridentBloc extends Bloc<IngridentEvent, IngridentState> {
  IngridentBloc() : super(const IngridentState()) {
    on<IngridentEvent>(
      (event, emit) => switch (event) {
        ToggleButton$IngridentEvent _ => _toggleButton(event, emit),
        FollowButton$IngridentEvent() => _followButton(event, emit),
        SaveButton$IngridentEvent() => _saveButton(event, emit),
      },
    );
  }

  void _toggleButton(
      ToggleButton$IngridentEvent event, Emitter<IngridentState> emit) {
    emit(state.copyWith(status: Status.loading));
    if (event.index == 0) {
      emit(
        state.copyWith(
            status: Status.success, isIngrident: true, isProcedure: false),
      );
    } else {
      emit(
        state.copyWith(
            status: Status.success, isIngrident: false, isProcedure: true),
      );
    }
  }

  void _followButton(
      FollowButton$IngridentEvent event, Emitter<IngridentState> emit) {
    emit(state.copyWith(status: Status.loading));
    emit(state.copyWith(status: Status.success, isFollow: !state.isFollow));
  }

  void _saveButton(
      SaveButton$IngridentEvent event, Emitter<IngridentState> emit) {
    emit(state.copyWith(status: Status.loading));
    emit(state.copyWith(status: Status.success, isSaved: !state.isSaved));
  }
}
