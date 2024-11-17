import 'package:flutter/material.dart';
import 'package:food_recipe/src/feature/ingrident/screen/ingrident_screen.dart';
import 'package:food_recipe/src/feature/notification/screen/notification_screen.dart';
import 'package:food_recipe/src/feature/saved/screen/saved_screen.dart';
import 'package:go_router/go_router.dart';

import '../../feature/home_navigation.dart';
import '../../feature/welcome/screen/welcome_screen.dart';

class AppRouter {
  const AppRouter._();

  static const String welcome = "/welcome";
  static const String main = "/main";
  static const String home = "/home";
  static const String notification = "/notification";
  static const String profile = "/profile";
  static const String saved = "/saved";
  static const String ingrident = "/ingrident";
}


final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell-key');
final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell-key');
late StatefulNavigationShell navigationShell2;

GoRouter router = GoRouter(
  navigatorKey: appNavigatorKey,
  initialLocation: AppRouter.home,
  routes: [
    GoRoute(
      path: AppRouter.ingrident,
      name: AppRouter.ingrident,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const IngridentScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
GoRoute(
      path: AppRouter.welcome,
      name: AppRouter.welcome,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const WelcomeScreen(),
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
              pageBuilder: (context, state) => const NoTransitionPage(child: Scaffold(body: Center(child: Text("Home")))),
              routes: const [],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.saved,
              pageBuilder: (context, state) => const NoTransitionPage(child: SavedScreen()),
              routes: const [],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.notification,
              pageBuilder: (context, state) => const NoTransitionPage(child: NotificationScreen()),
              routes: const [],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.profile,
              pageBuilder: (context, state) => const NoTransitionPage(child: Scaffold(body: Center(child: Text("Profile"),),)),
              routes: const [],
            ),
          ],
        ),
      ],
    ),
  ],
);

