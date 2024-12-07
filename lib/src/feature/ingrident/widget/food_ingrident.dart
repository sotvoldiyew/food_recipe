
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe/src/common/style/app_icons.dart';
import 'package:food_recipe/src/common/style/app_images.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';
import 'package:food_recipe/src/feature/ingrident/bloc/ingrident_bloc.dart';
class FoodIngrident extends StatefulWidget {
  const FoodIngrident({super.key});

  @override
  State<FoodIngrident> createState() => _FoodIngridentState();
}

class _FoodIngridentState extends State<FoodIngrident> {

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
            const Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  BlocBuilder<IngridentBloc, IngridentState>(
                    builder: (BuildContext context, IngridentState state) => InkWell(
                      onTap: () {
                        context.read<IngridentBloc>().add(const SaveButton$IngridentEvent());
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
    );
  }
}
