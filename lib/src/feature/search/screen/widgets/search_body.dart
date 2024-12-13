import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/search/bloc/search_bloc.dart';
import 'package:food_recipe/src/feature/search/screen/widgets/food_info.dart';

import '../../../../common/model/search_model.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({
    super.key,
    required this.recipes,
    required this.isTyped,
    required this.recentRecipes,
  });

  final List<SearchModel> recipes;
  final List<SearchModel> recentRecipes;
  final bool isTyped;

  @override
  Widget build(BuildContext context) {
    if (!isTyped && recipes.isEmpty && recentRecipes.isNotEmpty) {
      return BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: context.colors.onPrimary,
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        context.lang.recent_search,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: GridView.builder(
                itemCount: state.recentRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = recentRecipes[index];
                  return SavedRecipe(
                    image: recipe.imageUrl,
                    text: recipe.title,
                    byName: recipe.author,
                    reputation: recipe.averageRating,
                    id: recipe.id,
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio:
                      .9, // balandlikni katta yoki kichiklashtirish
                ),
              ),
            ),
          );
        },
      );
    }
    else if (isTyped && recipes.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            context.lang.no_recipes,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colors.outline,
            ),
          ),
        ),
      );
    }
    else if (recentRecipes.isEmpty && !isTyped) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            context.lang.no_recent_recipes,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colors.outline,
            ),
          ),
        ),
      );
    }
    else {
      return BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: context.colors.onPrimary,
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Text(
                          context.lang.search_result,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          "${state.recipes.length} results",
                          style: context.textTheme.titleSmall?.copyWith(
                            color: context.colors.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
              body: GridView.builder(
                itemCount: state.recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return SavedRecipe(
                    image: recipe.imageUrl,
                    text: recipe.title,
                    byName: 'By ${recipe.author}',
                    reputation: recipe.averageRating,
                    id: recipe.id,
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio:
                      .9, // balandlikni katta yoki kichiklashtirish
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
