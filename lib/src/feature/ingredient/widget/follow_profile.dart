import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/ingredient/bloc/ingredient_bloc.dart';
import 'package:food_recipe/src/feature/ingredient/data/follow_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/style/app_icons.dart';
import '../../../common/style/app_images.dart';

class FollowProfile extends StatefulWidget {
  const FollowProfile({super.key, required this.name, required this.lacation, required this.image, required this.userId});
  final String name;
  final String lacation;
  final String image;
  final int userId;

  @override
  State<FollowProfile> createState() => _FollowProfileState();
}

class _FollowProfileState extends State<FollowProfile> {

  void submitRecipe(BuildContext context, int recipeId, String token) async {
    FollowRepository followRepository = FollowRepository();

    await followRepository.follow(recipeId, token);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Recipe saved successfully!")),
    );

  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void saveRecipe(BuildContext context, int userId) async {
    String? token = await getToken();
    if (token != null) {
      submitRecipe(context, userId, token);
      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text("successfully")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Token is missing")),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ClipOval(
          child: CircleAvatar(
            child: Image(
              image: AssetImage( AppImages.userImage),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          children: [
            Text(
              widget.name,
              style: context.textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(AppIcons.location),
                Text(
                  widget.lacation,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            )
          ],
        ),
        const Spacer(),
        BlocBuilder<IngredientBloc, IngredientState>(
          builder: (context, state) => MaterialButton(
            splashColor: Colors.transparent,
            elevation: 0,
            height: 45,
            minWidth: 90,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: context.colors.primary, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            color: state.isFollow
                ? context.colors.onPrimary
                : context.colors.primary,
            child: Text(
              state.isFollow ? context.lang.following : context.lang.follow,
              style: context.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: state.isFollow
                    ? context.colors.primary
                    : context.colors.onPrimary,
              ),
            ),
            onPressed: () async {
              String? token = await getToken();

              submitRecipe(context, widget.userId,token!);
              context
                  .read<IngredientBloc>()
                  .add(const FollowButton$IngredientEvent());
            },
          ),
        )
      ],
    );
  }
}