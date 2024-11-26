part of 'ingrident_bloc.dart';

sealed class IngridentEvent {
  const IngridentEvent();
}

final class ToggleButton$IngridentEvent extends IngridentEvent {
  const ToggleButton$IngridentEvent(this.index);

  final int index;
}

final class FollowButton$IngridentEvent extends IngridentEvent {
  const FollowButton$IngridentEvent();
}

final class SaveButton$IngridentEvent extends IngridentEvent {
  const SaveButton$IngridentEvent();
}
