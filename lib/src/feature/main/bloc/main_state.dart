part of 'main_bloc.dart';

class MainState extends Equatable {
  final Status status;
  final List<RecipeModel> recipes;
  final List<RecipeModel> newRecipes;
  final List<CategoryModel> categories;
  final int selectedCategoryId;

  const MainState({
    this.status = Status.initial,
    this.recipes = const [],
    this.categories = const [],
    this.newRecipes = const [],
    this.selectedCategoryId = 1,
  });

  MainState copyWith({
    final Status? status,
    final List<RecipeModel>? recipes,
    final List<CategoryModel>? categories,
    final List<RecipeModel>? newRecipes,
    final int? selectedCategoryId,
  }) =>
      MainState(
        status: status ?? this.status,
        recipes: recipes ?? this.recipes,
        categories: categories ?? this.categories,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
        newRecipes: newRecipes ?? this.newRecipes,
      );

  @override
  List<Object?> get props => [
    status,
    recipes,
    categories,
    selectedCategoryId,
    newRecipes,
  ];
}
