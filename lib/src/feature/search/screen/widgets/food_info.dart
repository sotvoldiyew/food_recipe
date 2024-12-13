import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe/src/common/style/app_icons.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/router/app_router.dart';
import '../../../../common/style/app_images.dart';
import '../../bloc/search_bloc.dart';

class SavedRecipe extends StatelessWidget {
  const SavedRecipe({
    required this.image,
    required this.text,
    required this.byName,
    required this.reputation,
    required this.id,
    super.key,
  });

  final String image;
  final String text;
  final String byName;
  final double reputation;
  final int id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SearchBloc>().add(
              AddRecentRecipe$SearchEvent(
                context: context,
                id: id,
              ),
            );
        context.push(AppRouter.ingrident);
      },
      child: SizedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              // Image layer
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: image,
                  errorWidget: (context, url, error) {
                    return const Center(
                      child: Image(
                        image: AssetImage(AppImages.chef),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  placeholder: (context, url) => CircularProgressIndicator(
                    color: context.colors.onPrimary,
                  ),
                  fit: BoxFit.cover,
                ),
              ),

              // Gradiant
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

              // Text
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // const SizedBox(height: 4),
                    Text(
                      byName,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colors.outline,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: SizedBox(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colors.onSecondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 5,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppIcons.star,
                              width: 10,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              reputation.toString(),
                              style: context.textTheme.bodySmall,
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
