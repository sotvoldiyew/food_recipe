import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/bloc/recipe_bloc.dart';
import 'package:food_recipe/src/feature/create/bloc/create_bloc.dart';
import 'package:food_recipe/src/feature/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:food_recipe/src/feature/edit_profile/screen/edit_profile.dart';
import 'package:food_recipe/src/feature/ingrident/bloc/ingrident_bloc.dart';
import 'package:food_recipe/src/feature/ingrident/screen/ingrident_screen.dart';
import 'package:food_recipe/src/feature/profile/screen/profile_screen.dart';
import 'package:food_recipe/src/feature/profile/widget/see_followers.dart';
import 'package:food_recipe/src/feature/saved/bloc/saved_bloc.dart';
import 'package:food_recipe/src/feature/saved/screen/saved_screen.dart';
import 'package:food_recipe/src/feature/reviews/screen/review.dart';
import 'package:go_router/go_router.dart';

import '../../feature/create/screen/create_screen.dart';
import '../../feature/home_navigation.dart';
import '../../feature/profile/bloc/profile_bloc.dart';
import '../../feature/home/screen/home_navigation.dart';
import '../../feature/main/screen/main_screen.dart';
import '../../feature/search/screen/search_screen.dart';

// import '../../feature/screens/welcome/screen/welcome_screen.dart';

class AppRouter {
  const AppRouter._();

  static const String welcome = "/welcome";
  static const String main = "/main";
  static const String home = "/home";
  static const String notification = "/notification";
  static const String profile = "/profile";
  static const String saved = "/saved";
  static const String search = "/search";
  static const String ingrident = "/ingrident";
  static const String profileTapBar = "/profileTapBar";
  static const String editProfile = "/editProfile";
  static const String createScreen = "/createScreen";
}

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell-key');
final GlobalKey<NavigatorState> appNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell-key');
late StatefulNavigationShell navigationShell2;

GoRouter router = GoRouter(
  navigatorKey: appNavigatorKey,
  initialLocation: AppRouter.home,
  routes: [
    GoRoute(
      path: AppRouter.search,
      name: AppRouter.search,
      path: AppRouter.ingrident,
      name: AppRouter.ingrident,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider(
          child: const IngridentScreen(),
          create: (context) => IngridentBloc(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRouter.editProfile,
      name: AppRouter.editProfile,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: SearchScreen(
          allRecipes: state.extra as List<Map<String, Object?>>,
        ),
        child: BlocProvider(create: (BuildContext context) => EditProfileBloc(),
        child: const EditProfile()),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),

    GoRoute(
      path: AppRouter.createScreen,
      name: AppRouter.createScreen,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child:  BlocProvider(create: (BuildContext context) => CreateBloc(),
        child: const CreateScreen()),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),

    GoRoute(
      path: AppRouter.profileTapBar,
      name: AppRouter.profileTapBar,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider(
          child: const ProfileTabBarPage(),
          create: (context) => IngridentBloc(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: appNavigatorKey,
      builder: (context, state, navigationShell) {
        navigationShell2 = navigationShell;
        return HomeNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKey,
          routes: [
            GoRoute(
              path: AppRouter.home,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: MainScreen(),
              ),
              routes: const [],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.notification,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ReviewsPage(),
                // Scaffold(body: Center(child: Text(""))),
              ),
              routes: const [],
            ),
              path: AppRouter.saved,
              pageBuilder: (context, state) => NoTransitionPage(
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => SavedBloc(),
                    ),
                    BlocProvider(
                      create: (context) => RecipeBloc(),
                    ),
                  ],
                  child: const SavedScreen(),
                ),
              ),
            )
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.saved,
              pageBuilder: (context, state) => const NoTransitionPage(
                  child: Scaffold(
                body: Center(
                  child: Text("Saved"),
                ),
              )),
              path: AppRouter.notification,
              pageBuilder: (context, state) => const NoTransitionPage(
                  child: Scaffold(
                body: Center(
                  child: Text("Natficasion"),
                ),
              )),
              routes: const [],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.profile,
              pageBuilder: (context, state) => NoTransitionPage(
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => ProfileBloc()),
                    BlocProvider(create: (context) => RecipeBloc()),
                  ],
                  child: const ProfileScreen(),
                ),
              ),
            )
          ],
        ),
      ],
    ),
  ],
);
