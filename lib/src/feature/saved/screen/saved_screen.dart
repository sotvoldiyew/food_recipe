import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/model/recipe_model.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/common/constants/constants.dart';
import 'package:food_recipe/src/common/service/new_dio_service.dart';
import 'package:food_recipe/src/feature/profile/data/content_model.dart';
import 'package:food_recipe/src/feature/saved/widget/saved_recipe.dart';

import '../../profile/data/profile_recipe_model.dart';
import 'new_saved_widget.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List<Datum> list = [];

  Future<void> getSavedProducts() async {
    String? result = await NetworkService.get(
        Urls.savedRecipe, Urls.savedProductParam(size: 10), context);

    if(result != null){
      final product = profileContentFromJson(result);
      list = product.data!;
      setState(() {});
    }
  }

  @override
  void initState() {
    getSavedProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onPrimary,
      appBar: AppBar(
        backgroundColor: context.colors.onPrimary,
        title: Text(
          context.lang.savedRecipes,
          style: context.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final model = list[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
              child: NewSavedWidget(model: model),
            );
          }),
    );
  }
}
