import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe/src/common/style/app_icons.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';
import 'package:food_recipe/src/feature/ingrident/widget/follow_profile.dart';
import 'package:food_recipe/src/feature/ingrident/widget/food_ingrident.dart';
import 'package:food_recipe/src/feature/ingrident/widget/ingrident_items.dart';

class IngridentScreen extends StatefulWidget {
  const IngridentScreen({super.key});

  @override
  State<IngridentScreen> createState() => _IngridentScreenState();
}

class _IngridentScreenState extends State<IngridentScreen> {
  bool isIngrident = true;
  bool isProcedure = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.onPrimary,
        // leading: SvgPicture.asset(
        //   AppIcons.backButton,
        // ),
      ),
      backgroundColor: context.colors.onPrimary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
            child: Column( children:[
              const FoodIngrident(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Spicy chicken burger with French fries",
                        style: context.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "(13${context.lang.foodReviews})",
                        style: context.textTheme.titleSmall?.copyWith(
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const FollowProfile(),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      splashColor: Colors.transparent,
                      elevation: 0,
                      height: 45,
                      minWidth: 90,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: isIngrident
                          ? context.colors.onPrimary
                          : context.colors.primary,
                      child: Text( context.lang.ingrident,
                        style: context.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: isIngrident
                              ? context.colors.primary
                              : context.colors.onPrimary,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isProcedure = !isProcedure;
                          isIngrident = !isIngrident;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: MaterialButton(
                      splashColor: Colors.transparent,
                      elevation: 0,
                      height: 45,
                      minWidth:90 ,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: isProcedure
                          ? context.colors.onPrimary
                          : context.colors.primary,
                      child: Text( context.lang.procedure,
                        style: context.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: isProcedure
                              ? context.colors.primary
                              : context.colors.onPrimary,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isProcedure = !isProcedure;
                          isIngrident = !isIngrident;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              const IngridentItems(),

            ],
            )
        ),
      ),
    );
  }
}
