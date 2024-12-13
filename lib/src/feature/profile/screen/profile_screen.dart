import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/router/app_router.dart';
import 'package:food_recipe/src/common/service/new_dio_service.dart';
import 'package:food_recipe/src/common/style/app_images.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';
import 'package:food_recipe/src/feature/profile/bloc/profile_bloc.dart';
import 'package:food_recipe/src/feature/profile/data/content_model.dart';
import 'package:food_recipe/src/feature/profile/widget/my_sliver_delegete.dart';
import 'package:food_recipe/src/feature/profile/widget/view_more.dart';
import 'package:food_recipe/src/feature/saved/widget/saved_recipe.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants/constants.dart';
import '../data/profile_model.dart';
import '../data/profile_repository.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileRepository profileRepository;
  late final ProfileContent content;
  List<Datum> list = [];
  final dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
    ),
  );

  Future<void> getProduct() async {
    int? id = context.dependencies.shp.getInt('user_id');
    if (id != null) {
      String? result = await NetworkService.get(Urls.profileContent, Urls.profileContentParam(id: id, size: 10), context);

      if (result != null) {
        content = profileContentFromJson(result);
        list = content.data!;
        setState(() {});
      }
    }
  }


  @override
  void initState() {
    super.initState();
    profileRepository = ProfileRepository(
      dio: dio,
      getHeaders: () async {
        return {'Authorization': 'Bearer ${context.dependencies.shp.getString("token") ?? ""}'};
      },
    );
  }

  @override
  void didChangeDependencies() async {
    await getProduct();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onPrimary,
      body: FutureBuilder<UserProfile?>(
          future: profileRepository.fetchUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('No user profile found.'));
            }

            final userProfile = snapshot.data!;
            context.dependencies.shp.setString("role", userProfile.data!.userRole);
            log("user id ${context.dependencies.shp.setInt("user_id", userProfile.data!.userId).toString()}");
            return Padding(
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
                                  position: const RelativeRect.fromLTRB(100, 10, 0, 0),
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
                                    PopupMenuItem(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Logout'),
                                              content: const Text('Are you sure you want to log out?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  child: const Text('No'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    context.dependencies.shp.remove("token");
                                                    context.go(AppRouter.welcome);
                                                  },
                                                  child: const Text('Yes'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      value: 'option2',
                                      child: const Row(
                                        children: [Icon(Icons.login), SizedBox(width: 10), Text("Log out")],
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
                            style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
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
                              ClipOval(
                                child: CircleAvatar(
                                  radius: 40,
                                  child: Image(
                                    image: AssetImage(
                                      userProfile.data?.authorImg ?? AppImages.userImage,
                                    ),
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
                                      padding: WidgetStatePropertyAll(EdgeInsets.zero),
                                      overlayColor: WidgetStatePropertyAll(
                                        Colors.transparent,
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "${userProfile.data?.recipeNumber ?? 0}",
                                      style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
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
                                      "${userProfile.data?.followersCount ?? 0}",
                                      style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
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
                                    style: const ButtonStyle(overlayColor: WidgetStatePropertyAll(Colors.transparent)),
                                    onPressed: () {
                                      context.push(AppRouter.profileTapBar);
                                    },
                                    child: Text(
                                      "${userProfile.data?.followingCount ?? 0}",
                                      style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
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
                            "${userProfile.data?.userName}",
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Text(
                            "${userProfile.data?.userRole}",
                            style: context.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 15)),
                        SliverToBoxAdapter(
                          child: BlocProvider(
                              create: (context) => ProfileBloc(),
                              child: userProfile.data?.description?.length != null && userProfile.data!.description!.length <= 100
                                  ? MyViewMore(
                                      text: userProfile.data?.description ?? "",
                                    )
                                  : const SizedBox.shrink()),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(height: 15),
                        ),
                        if (userProfile.data?.userRole == "CHEF")
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: MySliverDelegete(),
                          )
                        else
                          const SliverToBoxAdapter(),
                      ],
                  body: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final model = list[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: SizedBox(
                          height: 170,
                          child: SavedRecipe(
                            model: model,
                          ),
                        ),
                      );
                    },
                  )),
            );
          }),
    );
  }
}
