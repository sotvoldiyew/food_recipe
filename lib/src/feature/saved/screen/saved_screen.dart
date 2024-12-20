import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/common/constants/constants.dart';
import 'package:food_recipe/src/common/service/new_dio_service.dart';
import 'package:food_recipe/src/feature/profile/data/content_model.dart';

import 'new_saved_widget.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => SavedScreenState();
}

class SavedScreenState extends State<SavedScreen> {
  bool isLoading = true;
  List<Datum> list = [];

  Future<void> getSavedProducts() async {
    String? result = await NetworkService.get(
        Urls.savedRecipe, Urls.savedProductParam(size: 10), context);

    if (result != null) {
      final product = profileContentFromJson(result);
      list = product.data!;
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> refreshData() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Yuklashni simulyatsiya qilish
    await getSavedProducts();
    setState(() {});
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
        onRefresh: refreshData,
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final model = list[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 25),
                    child: NewSavedWidget(recipeId: model.id!),
                  );
                }),
          ),
    );
  }
}
