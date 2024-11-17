import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';
import 'package:food_recipe/src/feature/ingrident/widget/follow_profile.dart';
import 'package:food_recipe/src/feature/ingrident/widget/food_ingrident.dart';
import 'package:food_recipe/src/feature/ingrident/widget/ingrident_items.dart';
import 'package:food_recipe/src/feature/ingrident/widget/procedure_steps.dart';

import '../../../common/style/app_icons.dart';

enum SampleItem { itemOne, itemTwo, itemThree, itemFour }

class IngridentScreen extends StatefulWidget {
  const IngridentScreen({super.key});

  @override
  State<IngridentScreen> createState() => _IngridentScreenState();
}

class _IngridentScreenState extends State<IngridentScreen> {
  bool isIngrident = true;
  bool isProcedure = false;

  void _toggleButton(int index) {
    setState(() {
      if (index == 0) {
        isIngrident = true;
        isProcedure = false;
      } else {
        isIngrident = false;
        isProcedure = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onPrimary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: context.colors.onPrimary,
              floating: true,
              pinned: true,
              shadowColor: Colors.transparent,
              // flexibleSpace: const FlexibleSpaceBar(),
              flexibleSpace: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back),
                  ),
                  IconButton(
                    onPressed: () {
                      showMenu(
                        color: context.colors.onPrimary,
                        context: context,
                        position: const RelativeRect.fromLTRB(100, 0, 0, 0),
                        items: <PopupMenuEntry<SampleItem>>[
                          PopupMenuItem<SampleItem>(
                            value: SampleItem.itemOne,
                            child: Row(
                              children: [
                                SvgPicture.asset(AppIcons.shareIcon),
                                const SizedBox(width: 8),
                                Text(context.lang.share),
                              ],
                            ),
                          ),
                          PopupMenuItem<SampleItem>(
                            value: SampleItem.itemTwo,
                            child: Row(
                              children: [
                                SvgPicture.asset(AppIcons.rateRecipe),
                                const SizedBox(width: 8),
                                Text(context.lang.rateRecipe),
                              ],
                            ),
                          ),
                          PopupMenuItem<SampleItem>(
                            value: SampleItem.itemThree,
                            child: Row(
                              children: [
                                SvgPicture.asset(AppIcons.reviewIcon),
                                const SizedBox(width: 8),
                                Text(context.lang.review),
                              ],
                            ),
                          ),
                          PopupMenuItem<SampleItem>(
                            value: SampleItem.itemFour,
                            child: Row(
                              children: [
                                SvgPicture.asset(AppIcons.saveBlack),
                                const SizedBox(width: 8),
                                Text(context.lang.unsave),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                    icon: const Icon(Icons.more_horiz),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: FoodIngrident()),
            const SliverToBoxAdapter(child: SizedBox(height: 15)),
            SliverToBoxAdapter(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Spicy chicken burger with French fries",
                      style: context.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "(13${context.lang.foodReviews})",
                      style: context.textTheme.titleSmall?.copyWith(
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 15)),
            const SliverToBoxAdapter(child: FollowProfile()),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverPersistentHeader(
              pinned: true,
              delegate: MyHeaderDelegate(
                isIngrident: isIngrident,
                isProcedure: isProcedure,
                onToggle: _toggleButton,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 25)),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.serve),
                  Text(" 1 ${context.lang.serve}", style: context.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w400),),
                  Spacer(),
                  Text("10 ${isIngrident ? context.lang.items : context.lang.steps}", style: context.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w400),)
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 15)),
          ],
          body: isIngrident ? const IngridentItems() : const ProcedureSteps(),
        ),
      ),
    );
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  late final bool isIngrident;
  late final bool isProcedure;
  final ValueChanged<int> onToggle;

  MyHeaderDelegate({
    required this.isIngrident,
    required this.isProcedure,
    required this.onToggle,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: context.colors.onPrimary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              splashColor: Colors.transparent,
              elevation: 0,
              color: isIngrident
                  ? context.colors.primary
                  : context.colors.onPrimary,
              onPressed: () => onToggle(0),
              child: const Text('Button 1'),
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
              child: const Text('Button 2'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 28.0;

  @override
  double get minExtent => 20;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
