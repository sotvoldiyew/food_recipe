import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/router/app_router.dart';
import 'package:food_recipe/src/common/style/app_images.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';
import 'package:food_recipe/src/feature/profile/bloc/profile_bloc.dart';
import 'package:food_recipe/src/feature/profile/widget/my_sliver_delegete.dart';
import 'package:food_recipe/src/feature/profile/widget/view_more.dart';
import 'package:food_recipe/src/feature/saved/widget/saved_recipe.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onPrimary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.more_horiz),
                        onPressed: () {
                          showMenu(
                            color: context.colors.onPrimary,
                            context: context,
                            position:
                                const RelativeRect.fromLTRB(100, 10, 0, 0),
                            items: [
                              PopupMenuItem(
                                onTap: () {
                                  context.push(AppRouter.editProfile);
                                },
                                value: 'option1',
                                child: Row(
                                  children: [
                                    const Icon(Icons.edit),
                                    const SizedBox(width: 10),
                                    Text(context.lang.editProfile),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                    centerTitle: true,
                    title: Text(
                      context.lang.profile,
                      style: context.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    scrolledUnderElevation: 0,
                    automaticallyImplyLeading: false,
                    backgroundColor: context.colors.onPrimary,
                    floating: true,
                    pinned: true,
                    shadowColor: Colors.transparent,
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          child: Image(
                            image: AssetImage(
                              AppImages.profileImage,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              context.lang.recipe,
                              style: context.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(
                              style: const ButtonStyle(
                                padding:
                                    WidgetStatePropertyAll(EdgeInsets.zero),
                                overlayColor: WidgetStatePropertyAll(
                                  Colors.transparent,
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "4",
                                style: context.textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              context.lang.followers,
                              style: context.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(
                              style: const ButtonStyle(
                                overlayColor: WidgetStatePropertyAll(
                                  Colors.transparent,
                                ),
                              ),
                              onPressed: () {
                                context.push(AppRouter.profileTapBar);
                              },
                              child: Text(
                                "2.5M",
                                style: context.textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              context.lang.following,
                              style: context.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(
                              style: const ButtonStyle(
                                  overlayColor: WidgetStatePropertyAll(
                                      Colors.transparent)),
                              onPressed: () {
                                context.push(AppRouter.profileTapBar);
                              },
                              child: Text(
                                "4",
                                style: context.textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 15)),
                  SliverToBoxAdapter(
                    child: Text(
                      "Afuwape Abiodun",
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Text(
                      "Chef",
                      style: context.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 15)),
                  SliverToBoxAdapter(
                    child: BlocProvider(
                      create: (context) => ProfileBloc(),
                      child: const MyViewMore(
                        text:
                            "eifhbehvb rthbrh tbhbehbfeh h hvbrhfbrh hrhjrdbjefnv ejvejv rvj ervjkr ervjevjnvjnervjrvvjrejvrenv",
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 15),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: MySliverDelegete(),
                  ),
                ],
            body: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: SizedBox(
                  height: 170,
                  child: SavedRecipe(),
                ),
              ),
            )),
      ),
    );
  }
}
