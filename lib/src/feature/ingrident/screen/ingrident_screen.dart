import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe/src/common/router/app_router.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/ingrident/bloc/ingrident_bloc.dart';
import 'package:food_recipe/src/feature/ingrident/widget/follow_profile.dart';
import 'package:food_recipe/src/feature/ingrident/widget/food_ingrident.dart';
import 'package:food_recipe/src/feature/ingrident/widget/ingrident_items.dart';
import 'package:food_recipe/src/feature/ingrident/widget/procedure_steps.dart';
import 'package:go_router/go_router.dart';

import '../../../common/style/app_icons.dart';
import '../widget/my_delegate.dart';
import '../widget/rating.dart';

enum SampleItem { itemOne, itemTwo, itemThree, itemFour }

class IngridentScreen extends StatefulWidget {
  const IngridentScreen({super.key});

  @override
  State<IngridentScreen> createState() => _IngridentScreenState();
}

class _IngridentScreenState extends State<IngridentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onPrimary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: BlocBuilder<IngridentBloc, IngridentState>(
          builder: (context, state) => NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    context.pop(AppRouter.saved);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                scrolledUnderElevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: context.colors.onPrimary,
                floating: true,
                pinned: true,
                shadowColor: Colors.transparent,
                actions: [
                  IconButton(
                    onPressed: () {
                      showMenu(
                        color: context.colors.onPrimary,
                        context: context,
                        position: const RelativeRect.fromLTRB(100, 0, 0, 0),
                        items: <PopupMenuEntry<SampleItem>>[
                          PopupMenuItem<SampleItem>(
                            onTap: () {
                              showDialog(
                                // barrierColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          context.lang.recipeLink,
                                          style: context.textTheme.titleLarge
                                              ?.copyWith(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          context.lang.copyRecipe,
                                          style: context.textTheme.labelSmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(height: 10),
                                        Stack(
                                          children: [
                                            Card(
                                              color: context
                                                  .colors.primaryContainer,
                                              elevation: 0,
                                              child: SizedBox(
                                                height: 45,
                                                width: double.infinity,
                                                child: Center(
                                                  child: Text(
                                                    "app.Recipe.co/jollof_rice",
                                                    textAlign: TextAlign.start,
                                                    style: context
                                                        .textTheme.labelSmall
                                                        ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 5,
                                              right: 0,
                                              child: MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                height: 50,
                                                minWidth: 85,
                                                color: context.colors.primary,
                                                elevation: 0,
                                                padding: EdgeInsets.zero,
                                                onPressed: () async {
                                                  const textToCopy =
                                                      "app.Recipe.co/jollof_rice";
                                                  await Clipboard.setData(
                                                      const ClipboardData(
                                                          text: textToCopy));

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Row(
                                                        children: [
                                                          const Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color:
                                                                  Colors.white),
                                                          const SizedBox(
                                                              width: 10),
                                                          Text(
                                                            context
                                                                .lang.textSaved,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      backgroundColor: context
                                                          .colors.primary,
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      duration: const Duration(
                                                          seconds: 2),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  context.lang.copyLink,
                                                  style: context
                                                      .textTheme.labelSmall
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: context.colors
                                                              .onPrimary),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    backgroundColor: context.colors.onPrimary,
                                    elevation: 0,
                                  );
                                },
                              );
                            },
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
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Stack(
                                  children: [
                                    AlertDialog(
                                      title: Center(
                                        child: Text(
                                          context.lang.rateRecipe,
                                          style: context.textTheme.labelMedium,
                                        ),
                                      ),
                                      content: SizedBox(
                                        height: 100,
                                        child: MyRating(),
                                      ),
                                      actions: [
                                        MaterialButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          color: context.colors.secondary,
                                          elevation: 0,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              context.lang.send,
                                              style: context
                                                  .textTheme.labelSmall
                                                  ?.copyWith(
                                                color: context.colors.onPrimary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.close),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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
                            onTap: () {
                              context.push(AppRouter.review);
                            },
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
                                Text(context.lang.unsaved),
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
                    Text(
                      "(13${context.lang.foodReviews})",
                      style: context.textTheme.titleSmall?.copyWith(
                        color: Colors.black45,
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
                  isIngrident: state.isIngrident,
                  isProcedure: state.isProcedure,
                  onToggle: (value) {
                    context
                        .read<IngridentBloc>()
                        .add(ToggleButton$IngridentEvent(value));
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 25)),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    SvgPicture.asset(AppIcons.serve),
                    Text(
                      " 1 ${context.lang.serve}",
                      style: context.textTheme.labelSmall
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                    const Spacer(),
                    Text(
                      "10 ${state.isIngrident ? context.lang.items : context.lang.steps}",
                      style: context.textTheme.labelSmall
                          ?.copyWith(fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 15)),
            ],
            body: state.isIngrident
                ? const IngridentItems()
                : const ProcedureSteps(),
          ),
        ),
      ),
    );
  }
}
