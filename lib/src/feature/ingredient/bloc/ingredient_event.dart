part of 'ingredient_bloc.dart';

sealed class IngredientEvent {
  const IngredientEvent();
}

final class ToggleButton$IngredientEvent extends IngredientEvent {
  const ToggleButton$IngredientEvent(this.index);

  final int index;
}

final class FollowButton$IngredientEvent extends IngredientEvent {
  const FollowButton$IngredientEvent();
}

final class SaveButton$IngredientEvent extends IngredientEvent {
  const SaveButton$IngredientEvent();
}
