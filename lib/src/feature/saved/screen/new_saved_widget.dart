import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe/src/common/bloc/recipe_bloc.dart';
import 'package:food_recipe/src/common/model/recipe_model.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/router/app_router.dart';
import '../../../common/service/new_dio_service.dart';
import '../../../common/style/app_icons.dart';
import '../../ingredient/data/recipe_model.dart';
import '../saved_repository.dart';

class NewSavedWidget extends StatefulWidget {
  const NewSavedWidget({super.key, required this.recipeId});

  final int recipeId;

  @override
  State<NewSavedWidget> createState() => _NewSavedWidgetState();
}

class _NewSavedWidgetState extends State<NewSavedWidget> {
  RecipeInfo? recipeInfo;

  Future<void> getOneRecepWithId() async {
    log("\n\nget one product \n\n");

    String? retsep =
    await NetworkService.get("/recipeM/${widget.recipeId}", {}, context);

    if (retsep != null) {
      log("ifni ichiga tushdi ");
      recipeInfo = recipeInfoFromJson(retsep);
      setState(() {});
    } else {
      log("Ma'lumotni yuklashda xatolik.");
    }
  }

  @override
  void initState() {
    getOneRecepWithId();
    super.initState();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> saveRecipe(BuildContext context, int recipeId) async {
    String? token = await getToken();
    if (token != null) {
      RecipeService recipeService = RecipeService();
      await recipeService.saveRecipe(recipeId, token);
      getOneRecepWithId();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Token is missing")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final model = RecipeModel(
            id: recipeInfo!.data!.id!,
            title: recipeInfo!.data!.title!,
            imgUrl: recipeInfo?.data?.imageUrl,
            cookingTime: recipeInfo!.data!.cookingTime!,
            averageRating: recipeInfo!.data!.averageRating!,
            ownerImage: "",
            ownerName: recipeInfo!.data!.author,
            ownerId: recipeInfo!.data!.authorId);
        context.push(AppRouter.ingrident, extra: model.id);
      },
      child: SizedBox(
        width: double.infinity,
        height: 170,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  recipeInfo?.data?.imageUrl ??
                      "https://media.istockphoto.com/id/1316145932/photo/table-top-view-of-spicy-food.jpg?s=612x612&w=0&k=20&c=eaKRSIAoRGHMibSfahMyQS6iFADyVy1pnPdy1O5rZ98=",
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipeInfo?.data?.title ?? "",
                      style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.onPrimary,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text('${context.lang.by} ${recipeInfo?.data?.author}',
                        style: context.textTheme.bodySmall?.copyWith(
                            color: context.colors.onPrimary,
                            fontWeight: FontWeight.w300)),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Row(
                  children: [
                    SvgPicture.asset(AppIcons.timer),
                    const SizedBox(width: 4),
                    Text(
                      '${recipeInfo?.data!.cookingTime} ',
                      style: context.textTheme.bodySmall?.copyWith(
                          color: context.colors.onPrimary,
                          fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    BlocBuilder<RecipeBloc, RecipeState>(
                      builder: (context, state) => InkWell(
                        onTap: () {
                          saveRecipe(context, recipeInfo!.data!.id!);
                          setState(() {
                          });
                          context
                              .read<RecipeBloc>()
                              .add(const SaveButton$RecipeEvent());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.colors.onPrimary,
                          ),
                          child: recipeInfo!.data!.isSaved!
                              ? SvgPicture.asset(AppIcons.pressedSave)
                              : SvgPicture.asset(AppIcons.saveIcon),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: SizedBox(
                  height: 15,
                  width: 33,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colors.onSecondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              width: 10,
                              AppIcons.star,
                            ),
                            Text(
                              "${recipeInfo?.data?.averageRating}",
                              style: context.textTheme.bodySmall
                                  ?.copyWith(fontSize: 9),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
