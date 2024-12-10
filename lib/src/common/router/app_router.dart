import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/bloc/recipe_bloc.dart';
import 'package:food_recipe/src/feature/create/bloc/create_bloc.dart';
import 'package:food_recipe/src/feature/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:food_recipe/src/feature/edit_profile/screen/edit_profile.dart';
import 'package:food_recipe/src/feature/ingrident/bloc/ingrident_bloc.dart';
import 'package:food_recipe/src/feature/ingrident/screen/ingrident_screen.dart';
import 'package:food_recipe/src/feature/main/bloc/main_bloc.dart';
import 'package:food_recipe/src/feature/profile/screen/profile_screen.dart';
import 'package:food_recipe/src/feature/profile/widget/see_followers.dart';
import 'package:food_recipe/src/feature/reviews/bloc/review_bloc.dart';
import 'package:food_recipe/src/feature/saved/bloc/saved_bloc.dart';
import 'package:food_recipe/src/feature/saved/screen/saved_screen.dart';
import 'package:food_recipe/src/feature/reviews/screen/review.dart';
import 'package:food_recipe/src/feature/search/bloc/search_bloc.dart';
import 'package:food_recipe/src/feature/splash/screen/notifications_screen.dart';
import 'package:go_router/go_router.dart';

import '../../feature/create/screen/create_screen.dart';
import '../../feature/profile/bloc/profile_bloc.dart';
import '../../../home_navigation.dart';
import '../../feature/main/screen/main_screen.dart';
import '../../feature/search/screen/search_screen.dart';

// import '../../feature/screens/welcome/screen/welcome_screen.dart';
import '../../feature/splash/screen/login_screen.dart';
import '../../feature/splash/screen/signup_screen.dart';
import '../../feature/splash/screen/splash_screen.dart';

class AppRouter {
  const AppRouter._();

  static const String welcome = "/welcome";
  static const String signIn = "/signIn";
  static const String signup = "/signup";
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
  static const String review = "/review";
}

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell-key');
final GlobalKey<NavigatorState> appNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell-key');
late StatefulNavigationShell navigationShell2;

GoRouter router = GoRouter(
  navigatorKey: appNavigatorKey,
  initialLocation: AppRouter.signIn,
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
    GoRoute(
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
      path: AppRouter.search,
      name: AppRouter.search,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: BlocProvider<SearchBloc>(
          create: (BuildContext context) => SearchBloc()..add(
            GetRecipes$SearchEvent(context: context),
          ),
          child: const SearchScreen(),
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
        child: BlocProvider(
            create: (BuildContext context) => EditProfileBloc(),
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
        child: BlocProvider(
            create: (BuildContext context) => CreateBloc(),
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
    GoRoute(
      path: AppRouter.signIn,
      name: AppRouter.signIn,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SignInScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRouter.signup,
      name: AppRouter.signup,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SignUpScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRouter.review,
      name: AppRouter.review,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider(
          create: (BuildContext context) => ReviewBloc(),
          child: const ReviewsPage(),
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
              name: AppRouter.home,
              pageBuilder: (context, state) => NoTransitionPage(
                child: BlocProvider(
                  create: (context) => MainBloc()
                    ..add(
                      GetAllData$MainEvent(context: context),
                    ),
                  child: const MainScreen(),
                ),
              ),
              routes: const [],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.saved,
              name: AppRouter.saved,
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
              routes: const [],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouter.notification,
              name: AppRouter.notification,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: NotificationsScreen(),
              ),
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
