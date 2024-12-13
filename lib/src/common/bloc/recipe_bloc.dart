import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../utils/status_enum.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';


class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(const RecipeState()) {
    on<RecipeEvent>(
          (event, emit) => switch (event) {
        SaveButton$RecipeEvent() => _saveButton(event, emit),
      },
    );
  }

  void _saveButton(SaveButton$RecipeEvent event, Emitter<RecipeState> emit) {
    emit(state.copyWith(status: Status.loading));
    emit(state.copyWith(status: Status.success, isSaved: !state.isSaved));
  }
}
