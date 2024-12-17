import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe/src/common/model/recipe_model.dart';
import 'package:food_recipe/src/common/style/app_icons.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/profile/data/content_model.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/router/app_router.dart';
import '../../../../common/style/app_images.dart';

class RecipeCardInfo extends StatelessWidget {
  final RecipeModel model;

  const RecipeCardInfo({
    super.key, required this.model,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          context.push(AppRouter.ingrident, extra:  model);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.onPrimary,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: context.colors.outlineVariant,
                blurRadius: 6.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Wrap(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            "${model.title}",
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    CircleAvatar(
                      radius: 18,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(18),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: model.imgUrl??"https://media.istockphoto.com/id/1316145932/photo/table-top-view-of-spicy-food.jpg?s=612x612&w=0&k=20&c=eaKRSIAoRGHMibSfahMyQS6iFADyVy1pnPdy1O5rZ98=",
                          errorWidget: (context, url, error) {
                            return const Center(
                              child: Image(
                                image: AssetImage(AppImages.chef),
                              ),
                            );
                          },
                          placeholder: (context, url) =>
                              CircularProgressIndicator(
                            color: context.colors.onPrimary,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'By ${model.ownerName}',
                      style: TextStyle(
                        fontSize: 14,
                        color: context.colors.outline,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          size: 16,
                          color: context.colors.outline,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          model.cookingTime,
                          style: TextStyle(color: context.colors.outline),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        for (int i = 0; i < 5; i++)
                          SvgPicture.asset(
                            AppIcons.star,
                            height: 23,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    width: 200,
                    height: double.infinity,
                    imageUrl: model.imgUrl??"https://media.istockphoto.com/id/1316145932/photo/table-top-view-of-spicy-food.jpg?s=612x612&w=0&k=20&c=eaKRSIAoRGHMibSfahMyQS6iFADyVy1pnPdy1O5rZ98=",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
