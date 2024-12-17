import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe/src/common/router/app_router.dart';
import 'package:food_recipe/src/common/style/app_images.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/style/app_icons.dart';

class RecipeCard extends StatelessWidget {
  final String image;
  final String title;
  final String time;
  final double rating;

  const RecipeCard({
    super.key,
    required this.image,
    required this.title,
    required this.time,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        context.push(AppRouter.ingrident);
      },
      child: Container(
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
                    imageUrl: image,
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
                    width: double.infinity,
                    height: 140,
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
                                rating.toStringAsFixed(1),
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
              title,
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
                  child: Text(
                    time,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.outline,
                      overflow: TextOverflow.ellipsis,
                    )
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
