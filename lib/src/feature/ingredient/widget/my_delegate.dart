import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  late final bool isIngredient;
  late final bool isProcedure;
  final ValueChanged<int> onToggle;

  MyHeaderDelegate({
    required this.isIngredient,
    required this.isProcedure,
    required this.onToggle,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: context.colors.onPrimary,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              splashColor: Colors.transparent,
              height: 70,
              elevation: 0,
              color: isIngredient
                  ? context.colors.primary
                  : context.colors.onPrimary,
              onPressed: () => onToggle(0),
              child: Text(
                context.lang.ingredient,
                style: context.textTheme.labelLarge?.copyWith(
                  color: isIngredient
                      ? context.colors.onPrimary
                      : context.colors.primary,
                ),
              ),
            ),
          ),
          Expanded(
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              splashColor: Colors.transparent,
              height: 70,
              elevation: 0,
              color: isProcedure
                  ? context.colors.primary
                  : context.colors.onPrimary,
              onPressed: () => onToggle(1),
              child: Text(context.lang.procedure, style: context.textTheme.labelLarge?.copyWith(
                color: isProcedure
                    ? context.colors.onPrimary
                    : context.colors.primary,
              ),),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 38.0;

  @override
  double get minExtent => 38.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
