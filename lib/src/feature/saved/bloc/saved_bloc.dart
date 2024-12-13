import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipe/src/common/utils/status_enum.dart';

part 'saved_event.dart';

part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedBloc() : super(SavedState()) {
    on<SavedEvent>(
      (event, emit) => switch (event) {
        SaveButton$Savedevent() => _saveButton(event, emit),
      },
    );
  }

  void _saveButton(SaveButton$Savedevent event, Emitter<SavedState> emit) {
    emit(state.copyWith(status: Status.loading));
    emit(state.copyWith(status: Status.success, isSaved: !state.isSaved));
  }
}
