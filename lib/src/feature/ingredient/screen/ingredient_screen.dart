import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe/src/feature/ingredient/data/follow_repository.dart';
import 'package:food_recipe/src/common/router/app_router.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/ingredient/bloc/ingredient_bloc.dart';
import 'package:food_recipe/src/feature/ingredient/data/recipe_repository.dart';
import 'package:food_recipe/src/feature/ingredient/widget/follow_profile.dart';
import 'package:food_recipe/src/feature/ingredient/widget/ingredient_items.dart';
import 'package:food_recipe/src/feature/ingredient/widget/procedure_steps.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constants/constants.dart';
import '../../../common/service/new_dio_service.dart';
import '../../../common/style/app_icons.dart';
import '../data/copy_model.dart';
import '../data/ingridient_model.dart';
import '../data/recipe_model.dart';
import '../data/steps_model.dart';
import '../widget/food_ingredient.dart';
import '../widget/my_delegate.dart';
import '../widget/rating.dart';

enum SampleItem {
  itemOne,
  itemTwo,
  itemThree,
  itemFour,
}

class IngredientScreen extends StatefulWidget {
  const IngredientScreen({super.key, required this.recipeId});

  final int recipeId;

  @override
  State<IngredientScreen> createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  late RecipeRepository recipeRepository;

  RecipeInfo? recipeInfo;
  bool isLoading = true;
  List<Datumm> stepsList = [];
  List<Datum2> ingredientList = [];
  late Data2 copyLink;

  Future<void> getSteps() async {
    String? result = await NetworkService.get(
        Urls.steps(widget.recipeId), Urls.emptyParam(), context);
    if (result != null) {
      final model = stepsModelFromJson(result);
      stepsList = model.data!;
      setState(() {});
    } else {
      log("somth went wrong ");
    }
  }

  Future<void> getLink() async {
    String? result = await NetworkService.get(
        Urls.copyLink(widget.recipeId), Urls.emptyParam(), context);
    if (result != null) {
      final model = copyLinkFromJson(result);
      copyLink = model.data!;
      setState(() {});
    } else {
      log("somth went wrong ");
    }
  }

  Future<void> getIngredient() async {
    String? result = await NetworkService.get(
        Urls.ingrident(widget.recipeId), Urls.emptyParam(), context);
    if (result != null) {
      final model = ingedientModelFromJson(result);
      ingredientList = model.data!;
      setState(() {});
    } else {
      log("somth went wrong  iuerfherirgeriu ");
    }
  }

  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 1), () {
    //   setState(() {
    //     isLoading = false;
    //   });});
    getLink();
    getIngredient();
    getSteps();
    getOneRecepWithId();
    super.initState();
  }

  void follow(BuildContext context, int userId, String token) async {
    FollowRepository followRepository = FollowRepository();

    await followRepository.follow(userId, token);

  await  getOneRecepWithId();

  setState(() {

  });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Recipe saved successfully!")),
    );
  }

  void rateRecipe(
      BuildContext context, int recipeId, String token, Object rate) async {
    FollowRepository followRepository = FollowRepository();

    await followRepository.rate(recipeId, token, rate);

   await getOneRecepWithId();
   setState(() {

   });
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void saveRecipe(BuildContext context, int recipeId) async {
    String? token = await getToken();
    if (token != null) {
      follow(context, recipeId, token);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Token is missing")),
      );
    }
  }

  Future<void> getOneRecepWithId() async {
    log("\n\nget one product \n\n");

    String? retsep =
        await NetworkService.get("/recipeM/${widget.recipeId}", {}, context);
    String? ingredients =
        await NetworkService.get("/recipeM/${widget.recipeId}", {}, context);
    String? steps =
        await NetworkService.get("/recipeM/${widget.recipeId}", {}, context);

    if (retsep != null) {
      log("ifni ichiga tushdi ");
      recipeInfo = recipeInfoFromJson(retsep);
      setState(() {
        isLoading = false;
      });
    } else {
      log("Ma'lumotni yuklashda xatolik.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onPrimary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : BlocBuilder<IngredientBloc, IngredientState>(
                builder: (context, state) => NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      leading: IconButton(
                        onPressed: () {
                          context.pop(AppRouter.saved);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      scrolledUnderElevation: 0,
                      automaticallyImplyLeading: false,
                      backgroundColor: context.colors.onPrimary,
                      floating: true,
                      pinned: true,
                      shadowColor: Colors.transparent,
                      actions: [
                        IconButton(
                          onPressed: () {
                            showMenu(
                              color: context.colors.onPrimary,
                              context: context,
                              position:
                                  const RelativeRect.fromLTRB(100, 0, 0, 0),
                              items: <PopupMenuEntry<SampleItem>>[
                                PopupMenuItem<SampleItem>(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                context.lang.recipeLink,
                                                style: context
                                                    .textTheme.titleLarge
                                                    ?.copyWith(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                              const SizedBox(height: 15),
                                              Text(
                                                context.lang.copyRecipe,
                                                style: context
                                                    .textTheme.labelSmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                              const SizedBox(height: 10),
                                              Stack(
                                                children: [
                                                  Card(
                                                    color: context.colors
                                                        .primaryContainer,
                                                    elevation: 0,
                                                    child: SizedBox(
                                                      height: 45,
                                                      width: double.infinity,
                                                      child: Center(
                                                        child: Text(
                                                          "${copyLink.link}",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: context
                                                              .textTheme
                                                              .labelSmall
                                                              ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 5,
                                                    right: 0,
                                                    child: MaterialButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      height: 50,
                                                      minWidth: 85,
                                                      color: context
                                                          .colors.primary,
                                                      elevation: 0,
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () async {
                                                        String textToCopy =
                                                            "${copyLink.link}";
                                                        await Clipboard.setData(
                                                            ClipboardData(
                                                                text:
                                                                    textToCopy));

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Row(
                                                              children: [
                                                                const Icon(
                                                                    Icons
                                                                        .check_circle,
                                                                    color: Colors
                                                                        .white),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Text(
                                                                  context.lang
                                                                      .textSaved,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                            backgroundColor:
                                                                context.colors
                                                                    .primary,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            duration:
                                                                const Duration(
                                                                    seconds: 2),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        context.lang.copyLink,
                                                        style: context.textTheme
                                                            .labelSmall
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: context
                                                                    .colors
                                                                    .onPrimary),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          backgroundColor:
                                              context.colors.onPrimary,
                                          elevation: 0,
                                        );
                                      },
                                    );
                                  },
                                  value: SampleItem.itemOne,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(AppIcons.shareIcon),
                                      const SizedBox(width: 8),
                                      Text(context.lang.share),
                                    ],
                                  ),
                                ),
                                PopupMenuItem<SampleItem>(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Stack(
                                        children: [
                                          AlertDialog(
                                            title: Center(
                                              child: Text(
                                                context.lang.rateRecipe,
                                                style: context
                                                    .textTheme.labelMedium,
                                              ),
                                            ),
                                            content: SizedBox(
                                              height: 100,
                                              child: Center(
                                                child: RatingBar.builder(
                                                  itemSize: 30,
                                                  initialRating: recipeInfo!
                                                      .data!.averageRating!,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  itemCount: 5,
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) async{
                                                    String? token = await getToken();
                                                    rateRecipe(context, recipeInfo!.data!.id!, token!, rating);
                                                  },
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              MaterialButton(
                                                onPressed: () async  {
                                                  final snackBar = SnackBar(
                                                    content: Row(
                                                      children: [
                                                        Icon(Icons.check_circle, color: Colors.green[400]), // Muvaffaqiyat belgisi
                                                        const SizedBox(width: 10),
                                                        const Expanded(
                                                          child: Text(
                                                            "Successful!",
                                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    backgroundColor: Colors.grey[900], // Chiroyli qora fon
                                                    behavior: SnackBarBehavior.floating,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    duration: const Duration(seconds: 3),
                                                  );

                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                                  // String? token = await getToken();
                                                  // rateRecipe(context, recipeInfo!.data!.id!, token!, )
                                                  Navigator.of(context).pop();
                                                },
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                color: context.colors.secondary,
                                                elevation: 0,
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    context.lang.send,
                                                    style: context
                                                        .textTheme.labelSmall
                                                        ?.copyWith(
                                                      color: context
                                                          .colors.onPrimary,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.close),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  value: SampleItem.itemTwo,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(AppIcons.rateRecipe),
                                      const SizedBox(width: 8),
                                      Text(context.lang.rateRecipe),
                                    ],
                                  ),
                                ),
                                PopupMenuItem<SampleItem>(
                                  onTap: () {
                                    context.push(AppRouter.review);
                                  },
                                  value: SampleItem.itemThree,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(AppIcons.reviewIcon),
                                      const SizedBox(width: 8),
                                      Text(context.lang.review),
                                    ],
                                  ),
                                ),
                                // PopupMenuItem<SampleItem>(
                                //   value: SampleItem.itemFour,
                                //   child: Row(
                                //     children: [
                                //       SvgPicture.asset(AppIcons.saveBlack),
                                //       const SizedBox(width: 8),
                                //       Text(context.lang.unsave),
                                //     ],
                                //   ),
                                // )
                              ],
                            );
                          },
                          icon: const Icon(Icons.more_horiz),
                        ),
                      ],
                    ),

                    /// kommentga oldim
                    SliverToBoxAdapter(
                        child: FoodIngredient(
                      recipeId: widget.recipeId,
                    )),
                    const SliverToBoxAdapter(child: SizedBox(height: 15)),
                    SliverToBoxAdapter(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "${recipeInfo?.data?.title}",
                              style: context.textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          Text(
                            "",
                            style: context.textTheme.titleSmall?.copyWith(
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 15)),
                    SliverToBoxAdapter(
                        child: FollowProfile(
                      name: recipeInfo?.data?.author ?? "Chef",
                      lacation: " Uzbekistan",
                      image: recipeInfo?.data?.authorImageUrl ?? "",
                      recipeId: recipeInfo!.data!.id!,
                    )),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: MyHeaderDelegate(
                        isIngredient: state.isIngredient,
                        isProcedure: state.isProcedure,
                        onToggle: (value) {
                          context
                              .read<IngredientBloc>()
                              .add(ToggleButton$IngredientEvent(value));
                        },
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 25)),
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          SvgPicture.asset(AppIcons.serve),
                          Text(
                            " 1 ${context.lang.serve}",
                            style: context.textTheme.labelSmall
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                          const Spacer(),
                          Text(
                            " ${state.isIngredient ? "${ingredientList.length} ${context.lang.items}" : "${stepsList.length} ${context.lang.steps}"}",
                            style: context.textTheme.labelSmall
                                ?.copyWith(fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 15)),
                  ],
                  body: state.isIngredient
                      ? IngridentItems(
                          list: ingredientList,
                        )
                      : ProcedureSteps(list: stepsList),
                ),
              ),
      ),
    );
  }
}
