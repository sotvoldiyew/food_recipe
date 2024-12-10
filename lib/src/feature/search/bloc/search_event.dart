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
