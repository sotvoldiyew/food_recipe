import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/router/app_router.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';
import 'package:food_recipe/src/feature/main/screen/widgets/cuisine_button.dart';
import 'package:food_recipe/src/feature/main/screen/widgets/recipe_card.dart';
import 'package:food_recipe/src/feature/main/screen/widgets/recipe_card_info.dart';
import 'package:go_router/go_router.dart';

import '../bloc/main_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<Map<String, Object?>> allRecipes = [
    {
      "image": "assets/images/recipe1.png",
      "title": "Classic Greek Salad",
      "time": "15 Mins",
      "rating": 4.5,
      "cuisine": "Greek"
    },
    {
      "image": "assets/images/recipe2.png",
      "title": "Crunchy Nut Coleslaw",
      "time": "10 Mins",
      "rating": 3.5,
      "cuisine": "American"
    },
    {
      "image": "assets/images/recipe1.png",
      "title": "Tandoori Chicken",
      "time": "30 Mins",
      "rating": 4.7,
      "cuisine": "Indian"
    },
    {
      "image": "assets/images/recipe2.png",
      "title": "Spaghetti Carbonara",
      "time": "20 Mins",
      "rating": 4.2,
      "cuisine": "Italian"
    },
    {
      "image": "assets/images/recipe2.png",
      "title": "Egg Fried Rice",
      "time": "20 Mins",
      "rating": 4.1,
      "cuisine": "Chinese"
    },
    {
      "image": "assets/images/recipe2.png",
      "title": "Sushi Rolls",
      "time": "25 Mins",
      "rating": 4.8,
      "cuisine": "Japanese"
    },
  ];

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
              "Hello Jega",
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/recipe1.png"),
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
                              context.push(
                                AppRouter.search,
                                extra: allRecipes,
                              );
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
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: context.colors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.filter_list,
                            color: context.colors.onPrimary,
                          ),
                        ),
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
                            isSelected: state.categories[i].id ==
                                state.selectedCategoryId,
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
                                RecipeCard(
                                  image: state.recipes[i].imgUrl ?? "",
                                  title: state.recipes[i].title,
                                  time: state.recipes[i].cookingTime,
                                  rating: state.recipes[i].averageRating,
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
                        for (int i = 0; i < state.newRecipes.length; i++)
                          RecipeCardInfo(
                            title: state.newRecipes[i].title,
                            author: "James Milner",
                            time: state.newRecipes[i].cookingTime,
                            rating: state.newRecipes[i].averageRating,
                            image: state.newRecipes[i].imgUrl ?? "",
                          )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
