import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe/src/common/router/app_router.dart';
import 'package:food_recipe/src/common/style/app_icons.dart';
import 'package:food_recipe/src/common/style/app_images.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:go_router/go_router.dart';

import '../../../common/bloc/recipe_bloc.dart';

class SavedRecipe extends StatefulWidget {
  const SavedRecipe({super.key});

  @override
  State<SavedRecipe> createState() => _SavedRecipeState();
}

class _SavedRecipeState extends State<SavedRecipe> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(AppRouter.ingrident);
      },
      child: SizedBox(
        width: double.infinity,
        height: 170,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              // Image layer
              Positioned.fill(
                child: Image.asset(
                  AppImages.food1,
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
                      'Spicy fried rice mix\nchicken bali',
                      style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.onPrimary,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text('${context.lang.by} Spicy Nelly',
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
                      '20 ${context.lang.min}',
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
                              "4.0",
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
