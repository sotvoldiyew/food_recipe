import 'package:flutter/material.dart';
import 'package:food_recipe/src/feature/reviews/screen/review.dart';
import 'package:go_router/go_router.dart';

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
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: SearchScreen(
          allRecipes: state.extra as List<Map<String, Object?>>,
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
              routes: const [],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.profile,
              pageBuilder: (context, state) => const NoTransitionPage(
                  child: Scaffold(
                body: Center(
                  child: Text("Profile"),
                ),
              )),
              routes: const [],
            ),
          ],
        ),
      ],
    ),
  ],
);
