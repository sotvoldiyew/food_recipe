import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe/src/common/style/app_icons.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/ingredient/data/recipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/constants/constants.dart';
import '../../../common/service/new_dio_service.dart';
import '../../saved/saved_repository.dart';
import '../../saved/screen/saved_screen.dart';
import '../bloc/ingredient_bloc.dart';

class FoodIngredient extends StatefulWidget {
  const FoodIngredient({super.key, required this.recipeId});

  final int recipeId;

  @override
  State<FoodIngredient> createState() => _FoodIngredientState();
}

class _FoodIngredientState extends State<FoodIngredient> {
  RecipeInfo? recipeInfo;
  bool isLoading = true;
  bool isSave = false;

  Future<void> openYoutubeUrl(String youtubeUrl) async {
    final Uri url = Uri.parse(youtubeUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $youtubeUrl';
    }
  }


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

    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
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
      SavedScreenState().getSavedProducts();
      SavedScreenState().setState(() {

      });();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Token is missing")),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 170,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  // Image layer
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
                  const Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
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
                          '${recipeInfo?.data?.cookingTime} ${context.lang.min}',
                          style: context.textTheme.bodySmall?.copyWith(
                              color: context.colors.onPrimary,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        BlocBuilder<IngredientBloc, IngredientState>(
                          builder:
                              (BuildContext context, IngredientState state) {
                            return InkWell(
                              onTap: () async {
                                log("/nbool ==> ${recipeInfo!.data!.isSaved!}/n");

                                saveRecipe(context, widget.recipeId);

                                setState(() {});
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
                            );
                          },
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
                  Positioned(
                    top: 50 ,
                    left: 120,
                    child: MaterialButton(
                      focusColor: Colors.transparent,
                      elevation: 0,
                      hoverElevation: 0,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: (){openYoutubeUrl(recipeInfo!.data!.videoUrl!);},
                      child: const Image(
                          image: AssetImage("assets/images/play_button.png"),height: 60,),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
