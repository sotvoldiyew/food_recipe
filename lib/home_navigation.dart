import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe/src/common/router/app_router.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';
import 'package:go_router/go_router.dart';

import 'src/common/style/app_icons.dart';


class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      floatingActionButton: widget.navigationShell.currentIndex == 3 && context.dependencies.shp.getString("role") == "CHEF"
          ? Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(25),
              type: MaterialType.transparency,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  context.push(AppRouter.createScreen);
                },
                child: ClipOval(
                  child: SvgPicture.asset(
                    AppIcons.navCreate,
                    fit: BoxFit.contain,
                    width: 44,
                    height: 44,
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color: context.colors.onPrimary,
        elevation: 5,
        shadowColor: context.colors.primaryContainer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: SvgPicture.asset(
                width: 27,
                height: 27,
                widget.navigationShell.currentIndex == 0
                    ? AppIcons.pressedHome
                    : AppIcons.homeIcon,
              ),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: SvgPicture.asset(
                width: 27,
                height: 27,
                widget.navigationShell.currentIndex == 1
                    ? AppIcons.pressedSave
                    : AppIcons.saveIcon,
              ),
              onPressed: () => _onItemTapped(1),
            ),
            IconButton(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: SvgPicture.asset(
                width: 27,
                height: 27,
                widget.navigationShell.currentIndex == 2
                    ? AppIcons.pressedNotification
                    : AppIcons.notificationIcon,
              ),
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: SvgPicture.asset(
                width: 27,
                height: 27,
                widget.navigationShell.currentIndex == 3
                    ? AppIcons.pressedProfile
                    : AppIcons.profileIcon,
              ),
              onPressed: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
