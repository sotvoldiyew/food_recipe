part of 'recipe_bloc.dart';


sealed class RecipeEvent{
  const RecipeEvent();
}

class SaveButton$RecipeEvent extends RecipeEvent{
  const SaveButton$RecipeEvent();
}