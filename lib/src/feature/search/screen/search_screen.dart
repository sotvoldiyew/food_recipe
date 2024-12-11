import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/search/screen/widgets/search_body.dart';

import '../bloc/search_bloc.dart';
import '../controller/search_text_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SearchScreenController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: context.colors.onPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          context.lang.search_recipe,
          style: context.textTheme.titleMedium
              ?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search field
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 3,
                          color: context.colors.outlineVariant,
                        ),
                      ),
                      // Text form field ni bosilmagandagi holati
                      prefixIcon: Icon(
                        Icons.search,
                        color: context.colors.outline,
                      ),
                      hintText: context.lang.search_recipe,
                      labelStyle: context.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 3,
                          color: context.colors.outline,
                        ),
                      ),
                      fillColor: context.colors.onPrimary,
                      filled: true,
                      hintStyle: TextStyle(
                        color: context.colors.outline,
                      ),
                    ),
                    onChanged: (query) {
                      query.isNotEmpty ? debouncing.call(
                        () => context.read<SearchBloc>().add(
                              SearchRecipes$SearchEvent(
                                context: context,
                                searchText: query,
                              ),
                            ),
                      ) : context.read<SearchBloc>().add(
                        GetRecipes$SearchEvent(
                          context: context,
                        ),
                      );
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
                  child: Icon(
                    Icons.filter_list,
                    color: context.colors.onPrimary,
                  ),
                ),
              ],
            ),

            // Search body
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return SearchBody(
                    recentRecipes: state.recentRecipes,
                    recipes: state.recipes,
                    isTyped: state.searchText.isNotEmpty,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
