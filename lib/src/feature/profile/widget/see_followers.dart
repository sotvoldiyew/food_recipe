import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/style/app_images.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/ingredient/bloc/ingredient_bloc.dart';

class ProfileTabBarPage extends StatefulWidget {
  const ProfileTabBarPage({super.key});

  @override
  State<ProfileTabBarPage> createState() => _ProfileTabBarPageState();
}

class _ProfileTabBarPageState extends State<ProfileTabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onPrimary,
      appBar: AppBar(
        backgroundColor: context.colors.onPrimary,
        title:  Text(context.lang.followers),
        bottom: TabBar(
          controller: _tabController,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          indicatorColor: context.colors.primary,
          tabs: const [
            Tab(text: "Followers"),
            Tab(text: "Following"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: const Image(image: AssetImage(AppImages.profileImage),),
              ),
              title: Text(
                "Afuwape Abiodun",
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text('Chef'),
              trailing: BlocBuilder<IngredientBloc, IngredientState>(
                builder: (context, state) => MaterialButton(
                  splashColor: Colors.transparent,
                  elevation: 0,
                  height: 45,
                  minWidth: 90,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: context.colors.primary, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: state.isFollow ? context.colors.onPrimary : context.colors.primary,
                  child: Text(
                    state.isFollow ? context.lang.following : context.lang.follow,
                    style: context.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color:
                      state.isFollow ? context.colors.primary : context.colors.onPrimary,
                    ),
                  ),
                  onPressed: () {
                    context.read<IngredientBloc>().add(const FollowButton$IngredientEvent());
                  },
                ),
            ),
          )),

          ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) =>ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: const Image(image: AssetImage(AppImages.profileImage))
              ),
              title: Text(
                "Afuwape Abiodun",
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text('Chef'),
              trailing: BlocBuilder<IngredientBloc, IngredientState>(
                builder: (context, state) => MaterialButton(
                  splashColor: Colors.transparent,
                  elevation: 0,
                  height: 45,
                  minWidth: 90,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: context.colors.primary, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: state.isFollow ? context.colors.onPrimary : context.colors.primary,
                  child: Text(
                    state.isFollow ? context.lang.following : context.lang.follow,
                    style: context.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color:
                      state.isFollow ? context.colors.primary : context.colors.onPrimary,
                    ),
                  ),
                  onPressed: () {
                    context.read<IngredientBloc>().add(const FollowButton$IngredientEvent());
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
