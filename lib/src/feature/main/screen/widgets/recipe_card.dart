import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe/src/common/model/recipe_model.dart';
import 'package:food_recipe/src/common/router/app_router.dart';
import 'package:food_recipe/src/common/style/app_images.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/style/app_icons.dart';
import '../../../profile/data/content_model.dart';

class RecipeCard extends StatelessWidget {
  final RecipeModel model;

  const RecipeCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.colors.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: model.imgUrl ?? "https://media.istockphoto.com/id/1316145932/photo/table-top-view-of-spicy-food.jpg?s=612x612&w=0&k=20&c=eaKRSIAoRGHMibSfahMyQS6iFADyVy1pnPdy1O5rZ98=",
                  errorWidget: (context, url, error) {
                    return const Center(
                      child: Image(
                        image: AssetImage(AppImages.chef),
                      ),
                    );
                  },
                  placeholder: (context, url) => CircularProgressIndicator(
                    color: context.colors.onPrimary,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  height: 22,
                  width: 40,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colors.onSecondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              width: 13,
                              AppIcons.star,
                            ),
                            const Expanded(child: SizedBox()),
                            Text(
                              "${model.averageRating}",
                              style: context.textTheme.bodySmall
                                  ?.copyWith(fontSize: 10),
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
          const SizedBox(height: 8),
          Text(
            model.title ?? "",
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Expanded(child: SizedBox()),
          Row(
            children: [
              Icon(
                Icons.timer,
                size: 14,
                color: context.colors.outline,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text("${model.cookingTime}",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.outline,
                      overflow: TextOverflow.ellipsis,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
