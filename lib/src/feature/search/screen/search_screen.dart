import 'package:flutter/material.dart';

import 'package:food_recipe/src/common/utils/context_extention.dart';
import 'package:food_recipe/src/feature/search/screen/widgets/food_info.dart';

class SearchScreen extends StatefulWidget {
  final List<Map<String, Object?>> allRecipes;

  const SearchScreen({super.key, required this.allRecipes});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, Object?>> filteredResults = [];

  @override
  void initState() {
    super.initState();
    filteredResults = widget.allRecipes;
  }

  void _searchRecipes(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredResults = widget.allRecipes;
      } else {
        filteredResults = widget.allRecipes.where((recipe) {
          return (recipe["title"] as String)
              .toLowerCase()
              .contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Search recipes",
          style: context.textTheme.titleMedium
              ?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: context.colors.outlineVariant,
                        ),
                        hintText: "Search recipe",
                        labelStyle: context.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: context.colors.surfaceContainer,
                        filled: true,
                        hintStyle: TextStyle(
                          color: context.colors.outlineVariant,
                        )),
                    onChanged: (query) {
                      _searchRecipes(query);
                    },
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
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Search Result",
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                searchController.text == ""
                    ? const Text("")
                    : Text(
                        "255 saved",
                        style: context.textTheme.labelSmall,
                      ),
              ],
            ),
            const SizedBox(height: 8),
            // Displaying search results
            Expanded(
              child: GridView.builder(
                itemCount: filteredResults.length,
                itemBuilder: (context, index) {
                  final recipe = filteredResults[index];
                  return SavedRecipe(
                    image: recipe["image"] as String,
                    text: recipe["title"] as String,
                    byName: 'By Spicy Nelly',
                    reputation: recipe["rating"] as double,
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
          ],
        ),
      ),
    );
  }
}
