import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe/src/common/bloc/recipe_bloc.dart';
import 'package:food_recipe/src/common/model/recipe_model.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/profile/data/content_model.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/router/app_router.dart';
import '../../../common/style/app_icons.dart';
import '../saved_repository.dart';

class NewSavedWidget extends StatefulWidget {
  const NewSavedWidget({super.key, required this.model});

  final Datum model;

  @override
  State<NewSavedWidget> createState() => _NewSavedWidgetState();
}

class _NewSavedWidgetState extends State<NewSavedWidget> {
  void submitRecipe(BuildContext context, int recipeId, String token) async {
    RecipeService recipeService = RecipeService();

    await recipeService.saveRecipe(recipeId, token);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Recipe saved successfully!")),
    );

  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void saveRecipe(BuildContext context, int recipeId) async {
    String? token = await getToken();
    if (token != null) {
      submitRecipe(context, recipeId, token);
      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text("successfully")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Token is missing")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final model = RecipeModel(
            id: widget.model.id!,
            title: widget.model.title!,
            imgUrl: widget.model.imageUrl,
            cookingTime: widget.model.time!,
            averageRating: widget.model.averageRating!,
            ownerImage: "",
            ownerName: widget.model.author,
            ownerId: widget.model.id);
        context.push(AppRouter.ingrident, extra: model);
      },
      child: SizedBox(
        width: double.infinity,
        height: 170,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  widget.model.imageUrl ??
                      "https://media.istockphoto.com/id/1316145932/photo/table-top-view-of-spicy-food.jpg?s=612x612&w=0&k=20&c=eaKRSIAoRGHMibSfahMyQS6iFADyVy1pnPdy1O5rZ98=",
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.model.title ?? "",
                      style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.onPrimary,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text('${context.lang.by} ${widget.model.author}',
                        style: context.textTheme.bodySmall?.copyWith(
                            color: context.colors.onPrimary,
                            fontWeight: FontWeight.w300)),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Row(
                  children: [
                    SvgPicture.asset(AppIcons.timer),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.model.time} ',
                      style: context.textTheme.bodySmall?.copyWith(
                          color: context.colors.onPrimary,
                          fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    BlocBuilder<RecipeBloc, RecipeState>(
                      builder: (context, state) => InkWell(
                        onTap: () {
                          saveRecipe(context, widget.model.id!);
                          context
                              .read<RecipeBloc>()
                              .add(const SaveButton$RecipeEvent());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.colors.onPrimary,
                          ),
                          child: state.isSaved
                              ? SvgPicture.asset(AppIcons.pressedSave)
                              : SvgPicture.asset(AppIcons.saveIcon),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: SizedBox(
                  height: 15,
                  width: 33,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colors.onSecondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              width: 10,
                              AppIcons.star,
                            ),
                            Text(
                              "${widget.model.averageRating}",
                              style: context.textTheme.bodySmall
                                  ?.copyWith(fontSize: 9),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
