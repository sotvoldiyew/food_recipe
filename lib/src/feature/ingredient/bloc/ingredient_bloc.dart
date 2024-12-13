import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/utils/status_enum.dart';

part 'ingredient_event.dart';

part 'ingredient_state.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  IngredientBloc() : super(const IngredientState()) {
    on<IngredientEvent>(
      (event, emit) => switch (event) {
        ToggleButton$IngredientEvent _ => _toggleButton(event, emit),
        FollowButton$IngredientEvent() => _followButton(event, emit),
        SaveButton$IngredientEvent() => _saveButton(event, emit),
      },
    );
  }

  void _toggleButton(
      ToggleButton$IngredientEvent event, Emitter<IngredientState> emit) {
    emit(state.copyWith(status: Status.loading));
    if (event.index == 0) {
      emit(
        state.copyWith(
            status: Status.success, isIngredient: true, isProcedure: false),
      );
    } else {
      emit(
        state.copyWith(
            status: Status.success, isIngredient: false, isProcedure: true),
      );
    }
  }

  void _followButton(
      FollowButton$IngredientEvent event, Emitter<IngredientState> emit) {
    emit(state.copyWith(status: Status.loading));
    emit(state.copyWith(status: Status.success, isFollow: !state.isFollow));
  }

  void _saveButton(
      SaveButton$IngredientEvent event, Emitter<IngredientState> emit) {
    emit(state.copyWith(status: Status.loading));
    emit(state.copyWith(status: Status.success, isSaved: !state.isSaved));
  }
}
