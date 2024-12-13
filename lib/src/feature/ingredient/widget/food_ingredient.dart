
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe/src/common/style/app_icons.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';
import 'package:food_recipe/src/feature/ingrident/bloc/ingrident_bloc.dart';

import '../../profile/data/content_model.dart';
class FoodIngrident extends StatefulWidget {
  const FoodIngrident({super.key, required this.model});
 final Datum model;

import 'package:food_recipe/src/common/style/app_images.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/ingredient/bloc/ingredient_bloc.dart';

class FoodIngredient extends StatefulWidget {
  const FoodIngredient({super.key});

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
                widget.model.imageUrl ?? "data:image/jpeg;base64,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" ,
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
                    '${widget.model.time} ${context.lang.min}',
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
