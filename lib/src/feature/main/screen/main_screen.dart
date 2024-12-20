import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/router/app_router.dart';
import 'package:food_recipe/src/common/style/app_images.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/main/screen/widgets/cuisine_button.dart';
import 'package:food_recipe/src/feature/main/screen/widgets/recipe_card.dart';
import 'package:food_recipe/src/feature/main/screen/widgets/recipe_card_info.dart';
import 'package:go_router/go_router.dart';

import '../bloc/main_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        forceMaterialTransparency: true,
        backgroundColor: context.colors.onPrimary,
        elevation: 0,
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello Chef",
              style: context.textTheme.titleLarge?.copyWith(
                color: context.colors.onSecondaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              context.lang.what_cooking,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colors.outline,
              ),
            ),
          ],
        ),
        actions:  [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(AppImages.userImage),
            ),
          ),
        ],
      ),
      backgroundColor: context.colors.onPrimary,
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) => state.categories.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context.push(AppRouter.search);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: context.colors.surfaceContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: context.colors.outline,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    context.lang.search_recipe,
                                    style:
                                        context.textTheme.bodyMedium?.copyWith(
                                      color: context.colors.outline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Cuisine Filter Buttons
                  SizedBox(
                    height: 38,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        const SizedBox(width: 16),
                        for (int i = 0; i < state.categories.length; i++)
                          CuisineButton(
                            label: state.categories[i].name,
                            isSelected: state.categories[i].id == state.selectedCategoryId,
                            onTap: () {
                              context.read<MainBloc>().add(
                                    GetRecipesByCategory$MainEvent(
                                      context: context,
                                      category: state.categories[i].id,
                                    ),
                                  );
                            },
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Horizontal Recipe List
                  state.recipes.isNotEmpty
                      ? SizedBox(
                          height: 230,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              const SizedBox(width: 16),
                              for (int i = 0; i < state.recipes.length; i++)
                                InkWell(
                                  onTap: () {
                                    final model = state.recipes[i];
                                    context.push(AppRouter.ingrident, extra: model.id);
                                  },
                                  child: RecipeCard(model: state.recipes[i],

                                  ),
                                ),
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 230,
                          child: Center(
                            child: Text(
                              context.lang.no_recipes,
                              style: context.textTheme.bodyLarge,
                            ),
                          ),
                        ),
                  const SizedBox(height: 16),

                  // New Recipes
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      context.lang.new_recipes,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  

                  SizedBox(
                    height: 220,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        const SizedBox(width: 8),
                        ...List.generate(state.newRecipes.length, (index){
                          final model = state.newRecipes[index];
                          log("\n\nmodel cooking time ${model.cookingTime}\n\n");

                          return RecipeCardInfo(model: model);
                        }),
                        // for (int i = 0; i < state.newRecipes.length; i++)
                        //   RecipeCardInfo(model: state.newRecipes.,
                        //
                        //   )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
