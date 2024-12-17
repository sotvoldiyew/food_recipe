
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe/src/common/model/recipe_model.dart';
import 'package:food_recipe/src/common/style/app_icons.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';

import '../../profile/data/content_model.dart';
import '../bloc/ingredient_bloc.dart';




class FoodIngredient extends StatefulWidget {
  const FoodIngredient({super.key, required this.model});
  final RecipeModel model;

  @override
  State<FoodIngredient> createState() => _FoodIngredientState();
}

class _FoodIngredientState extends State<FoodIngredient> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 170,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // Image layer
            Positioned.fill(
              child: Image.network(
                widget.model.imgUrl ?? "https://media.istockphoto.com/id/1316145932/photo/table-top-view-of-spicy-food.jpg?s=612x612&w=0&k=20&c=eaKRSIAoRGHMibSfahMyQS6iFADyVy1pnPdy1O5rZ98=" ,fit: BoxFit.cover,
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
            const Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
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
                    '${widget.model.cookingTime} ${context.lang.min}',
                    style: context.textTheme.bodySmall?.copyWith(
                        color: context.colors.onPrimary,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  BlocBuilder<IngredientBloc, IngredientState>(
                    builder: (BuildContext context, IngredientState state) {
                      return InkWell(
                        onTap: () {
                          context.read<IngredientBloc>().add(
                                const SaveButton$IngredientEvent(),
                              );
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
                      );
                    },
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
    );
  }
}
