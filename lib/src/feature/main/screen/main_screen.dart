import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/router/app_router.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';
import 'package:food_recipe/src/feature/main/screen/widgets/cuisine_button.dart';
import 'package:food_recipe/src/feature/main/screen/widgets/recipe_card.dart';
import 'package:food_recipe/src/feature/main/screen/widgets/recipe_card_info.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController searchController = TextEditingController();

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

  final List<Map<String, Object?>> recipes = [
    {
      'title': 'Steak with tomato',
      'author': 'James Milner',
      'time': '20 mins',
      'rating': 4.5,
      'image': 'assets/images/steak.png',
    },
    {
      'title': 'Pilaf sweet rice',
      'author': 'Laura Clark',
      'time': '30 mins',
      'rating': 4.2,
      'image': 'assets/images/steak.png',
    },
    {
      'title': 'Chicken curry',
      'author': 'John Doe',
      'time': '25 mins',
      'rating': 4.7,
      'image': 'assets/images/steak.png',
    },
  ];

  List<Map<String, Object?>> filteredRecipes = [];

  String selectedCuisine = "All";
  List<String> cuisines = ["All", "Indian", "Italian", "Asian", "Chinese"];

  @override
  void initState() {
    super.initState();
    filteredRecipes = allRecipes;
  }

  void _filterRecipes(String cuisine) {
    setState(() {
      selectedCuisine = cuisine;
      if (cuisine == context.lang.all) {
        filteredRecipes = allRecipes;
      } else {
        filteredRecipes = allRecipes.where((recipe) {
        return recipe["cuisine"] == cuisine;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
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
              "What are you cooking today?",
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
      backgroundColor: Colors.white,
      body: ListView(
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
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(
                            "Search recipe",
                            style: TextStyle(color: Colors.grey),
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
                  child: const Icon(Icons.filter_list, color: Colors.white),
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
                for (int index = 0; index < cuisines.length; index++)
                  CuisineButton(
                    label: cuisines[index],
                    isSelected: cuisines[index] == selectedCuisine,
                    onTap: () {
                      _filterRecipes(cuisines[index]);
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Horizontal Recipe List
          SizedBox(
            height: 230,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(width: 16),
                for (int index = 0; index < filteredRecipes.length; index++)
                  RecipeCard(
                    image: filteredRecipes[index]["image"] as String,
                    title: filteredRecipes[index]["title"] as String,
                    time: filteredRecipes[index]["time"] as String,
                    rating: filteredRecipes[index]["rating"] as double,
                  ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              "New Recipes",
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(width: 8),
                for (int i = 0; i < 10; i++)
                  RecipeCardInfo(
                    title: recipes[i % 2]['title'] as String,
                    author: recipes[i % 2]['author'] as String,
                    time: recipes[i % 2]['time'] as String,
                    rating: recipes[i % 2]['rating'] as double,
                    image: recipes[i % 2]['image'] as String,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
