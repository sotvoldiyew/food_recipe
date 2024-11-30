import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';
import 'package:go_router/go_router.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        // selectedLabelStyle: context.appTextStyle.bodyMedium,
        // unselectedLabelStyle: context.appTextStyle.bodyMedium,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        unselectedFontSize: 8,  // Adjust sizes
        selectedFontSize: 10,
        unselectedItemColor: context.colors.outline,
        selectedItemColor: context.colors.tertiary,
        elevation: 0,
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (index) => _onItemTapped(index),
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
  }

  void _onItemTapped(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
