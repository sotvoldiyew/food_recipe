import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/ingredient/bloc/ingredient_bloc.dart';
import 'package:food_recipe/src/feature/ingredient/data/follow_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/service/new_dio_service.dart';
import '../../../common/style/app_icons.dart';
import '../../../common/style/app_images.dart';
import '../data/recipe_model.dart';

class FollowProfile extends StatefulWidget {
  const FollowProfile(
      {super.key,
      required this.name,
      required this.lacation,
      required this.image,
      required this.recipeId});

  final String name;
  final String lacation;
  final String image;
  final int recipeId;

  @override
  State<FollowProfile> createState() => _FollowProfileState();
}

class _FollowProfileState extends State<FollowProfile> {
  RecipeInfo? recipeInfo;
  bool isLoading = true;

  Future<void> getOneRecepWithId() async {
    String? retsep =
        await NetworkService.get("/recipeM/${widget.recipeId}", {}, context);

    if (retsep != null) {
      log("ifni ichiga tushdi ");
      recipeInfo = recipeInfoFromJson(retsep);
      log("saved value ==> ${recipeInfo!.data!.isSaved!}");
      setState(() {});
    } else {
      log("Ma'lumotni yuklashda xatolik.");
    }

    setState(() {
      isLoading = false;
    });
  }

  void submitRecipe(BuildContext context, int recipeId, String token) async {
    FollowRepository followRepository = FollowRepository();

    await followRepository.follow(recipeId, token);
    await  getOneRecepWithId();

    setState(() {

    });
  }

  void deleteFollow(BuildContext context, int recipeId, String token) async {
    FollowRepository followRepository = FollowRepository();

    await followRepository.unFollow(recipeId, token);
    await  getOneRecepWithId();

    setState(() {

    });
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void saveRecipe(BuildContext context, int userId) async {
    String? token = await getToken();
    if (token != null) {
      submitRecipe(context, userId, token);
      await getOneRecepWithId();
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Token is missing")),
      );
    }
  }

  void unFollow(BuildContext context, int userId) async {
    String? token = await getToken();
    if (token != null) {
      deleteFollow(context, userId, token);
      await getOneRecepWithId();
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Token is missing")),
      );
    }
  }

  @override
  void initState() {
    getOneRecepWithId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Row(
            children: [
              const ClipOval(
                child: CircleAvatar(
                  child: Image(
                    image: AssetImage(AppImages.userImage),
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
                builder: (context, state) => recipeInfo?.data?.isFollow == null
                    ? const Text("")
                    : MaterialButton(
                        splashColor: Colors.transparent,
                        elevation: 0,
                        height: 45,
                        minWidth: 90,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: context.colors.primary, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: recipeInfo!.data!.isFollow
                            ? context.colors.onPrimary
                            : context.colors.primary,
                        child: Text(
                          recipeInfo!.data!.isFollow
                              ? context.lang.following
                              : context.lang.follow,
                          style: context.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: recipeInfo!.data!.isFollow
                                ? context.colors.primary
                                : context.colors.onPrimary,
                          ),
                        ),
                        onPressed: () async {
                          String? token = await getToken();
                          if (recipeInfo!.data!.isFollow!) {
                            deleteFollow(
                                context, recipeInfo!.data!.authorId!, token!);
                          } else {
                            submitRecipe(
                                context, recipeInfo!.data!.authorId!, token!);
                          }
                          setState(() {});
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
