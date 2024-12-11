part of 'search_bloc.dart';

sealed class SearchEvent {
  const SearchEvent();
}

class SearchRecipes$SearchEvent extends SearchEvent {
  final BuildContext context;
  final String searchText;

  const SearchRecipes$SearchEvent({
    required this.context,
    required this.searchText,
  });
}

class GetRecipes$SearchEvent extends SearchEvent {
  final BuildContext context;

  const GetRecipes$SearchEvent({required this.context});
}

class AddRecentRecipe$SearchEvent extends SearchEvent {
  final BuildContext context;
  final int id;

  const AddRecentRecipe$SearchEvent({
    required this.context,
    required this.id,
  });
}
