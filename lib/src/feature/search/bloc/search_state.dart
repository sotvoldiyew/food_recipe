part of 'search_bloc.dart';

class SearchState extends Equatable {
  final Status status;
  final String searchText;
  final List<SearchModel> recipes;
  final List<SearchModel> recentRecipes;

  const SearchState({
    this.status = Status.initial,
    this.searchText = '',
    this.recipes = const [],
    this.recentRecipes = const [],
  });

  SearchState copyWith({
    final Status? status,
    final String? searchText,
    final List<SearchModel>? recipes,
    final List<SearchModel>? recentRecipes,
  }) =>
      SearchState(
        status: status ?? this.status,
        searchText: searchText ?? this.searchText,
        recipes: recipes ?? this.recipes,
        recentRecipes: recentRecipes ?? this.recentRecipes,
      );

  @override
  List<Object?> get props => [
    status,
    searchText,
    recipes,
    recentRecipes,
  ];
}
