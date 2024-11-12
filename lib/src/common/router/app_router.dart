import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../feature/screens/welcome/screen/welcome_screen.dart';

class AppRouter {
  const AppRouter._();

  static const String welcome = "/welcome";
  static const String main = "/main";
  static const String home = "/home";
  static const String notification = "/notification";
  static const String profile = "/profile";
  static const String saved = "/saved";
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: AppRouter.main,
  routes: [
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
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _calculateIndex(state.uri.toString()),
            onTap: (index) {
              switch (index) {
                case 0:
                  context.go(AppRouter.home);
                  break;
                case 1:
                  context.go(AppRouter.notification);
                  break;
                case 2:
                  context.go(AppRouter.saved);
                  break;
                case 3:
                  context.go(AppRouter.profile);
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: 'Saved',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
      routes: [
        // GoRoute(
        //   path: AppRouter.home,
        //   name: AppRouter.home,
        //   pageBuilder: (context, state) => NoTransitionPage(
        //     key: state.pageKey,
        //     child: const HomeScreen(),
        //   ),
        // ),
        // GoRoute(
        //   path: AppRouter.notification,
        //   name: AppRouter.notification,
        //   pageBuilder: (context, state) => NoTransitionPage(
        //     key: state.pageKey,
        //     child: const NotificationScreen(),
        //   ),
        // ),
        // GoRoute(
        //   path: AppRouter.saved,
        //   name: AppRouter.saved,
        //   pageBuilder: (context, state) => NoTransitionPage(
        //     key: state.pageKey,
        //     child: const SavedScreen(),
        //   ),
        // ),
        // GoRoute(
        //   path: AppRouter.profile,
        //   name: AppRouter.profile,
        //   pageBuilder: (context, state) => NoTransitionPage(
        //     key: state.pageKey,
        //     child: const ProfileScreen(),
        //   ),
        // ),
      ],
    ),
  ],
);

int _calculateIndex(String location) {
  switch (location) {
    case AppRouter.home:
      return 0;
    case AppRouter.notification:
      return 1;
    case AppRouter.saved:
      return 2;
    case AppRouter.profile:
      return 3;
    default:
      return 0;
  }
}
