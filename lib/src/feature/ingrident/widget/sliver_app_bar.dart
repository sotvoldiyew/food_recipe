
import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';

class SliverButtonRowDelegate extends SliverPersistentHeaderDelegate {
  SliverButtonRowDelegate({
    required this.isIngrident,
    required this.isProcedure,
    required this.onIngridentChanged,
    required this.onProcedureChanged,
  });

  final bool isIngrident;
  final bool isProcedure;
  final VoidCallback onIngridentChanged;
  final VoidCallback onProcedureChanged;

  @override
  double get minExtent => 60.0;
  @override
  double get maxExtent => 60.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: Row(
        children: [
          Expanded(
            child: MaterialButton(
              splashColor: Colors.transparent,
              elevation: 0,
              height: 45,
              minWidth: 90,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: isIngrident
                  ? context.colors.onPrimary
                  : context.colors.primary,
              child: Text(
                context.lang.ingrident,
                style: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isIngrident
                      ? context.colors.primary
                      : context.colors.onPrimary,
                ),
              ),
              onPressed: onIngridentChanged,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: MaterialButton(
              splashColor: Colors.transparent,
              elevation: 0,
              height: 45,
              minWidth: 90,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: isProcedure
                  ? context.colors.onPrimary
                  : context.colors.primary,
              child: Text(
                context.lang.procedure,
                style: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isProcedure
                      ? context.colors.primary
                      : context.colors.onPrimary,
                ),
              ),
              onPressed: onProcedureChanged,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverButtonRowDelegate oldDelegate) {
    return isIngrident != oldDelegate.isIngrident ||
        isProcedure != oldDelegate.isProcedure;
  }
}