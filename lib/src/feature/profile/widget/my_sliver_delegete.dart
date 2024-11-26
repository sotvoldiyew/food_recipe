import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';

class MySliverDelegete extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Center(
      child: Card(
        elevation: 0,
        color: context.colors.primary,
        child: SizedBox(
          height: 35,
          width: 130,
          child: Center(
            child: Text(
              context.lang.recipe,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
