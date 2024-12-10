import 'package:flutter/material.dart';
import 'package:food_recipe/src/feature/search/screen/search_screen.dart';

import '../../../common/utils/debouncing_throttling.dart';

mixin SearchScreenController on State<SearchScreen> {late TextEditingController searchController;

  final debouncing = Debouncing(const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    debouncing.dispose();
    searchController = TextEditingController();
  }
}