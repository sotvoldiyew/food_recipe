import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe/src/common/style/app_icons.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';

import '../../../common/style/app_images.dart';

class IngridentItems extends StatelessWidget {
  const IngridentItems({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: 15,
      itemBuilder: (context, index) => Card(
        elevation: 0,
        color: context.colors.primaryContainer,
        child: SizedBox(
          height: 80,
          width: double.infinity,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(9.0),
                child: Card(
                  elevation: 0,
                  child: Image(
                    image: AssetImage(AppImages.tomatoes),
                  ),
                ),
              ),
              Text(
                "Tomatos",
                style: context.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text("500g"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
