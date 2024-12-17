import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/model/comment_model.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:intl/intl.dart';

import '../../../../common/style/app_images.dart';

class Comment extends StatelessWidget {
  const Comment({
    super.key,
    required this.commentModel,
    required this.onTapLike,
    required this.userId,
    required this.onTapDislike,
    required this.onLongPressDown,
    this.hasReaction,
  });

  final CommentModel commentModel;
  final int userId;
  final void Function() onTapLike;
  final void Function() onTapDislike;
  final bool? hasReaction;
  final void Function(
    BuildContext,
    Offset, {
    required CommentModel commentModel,
    required int userId,
  }) onLongPressDown;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) {
        onLongPressDown(
          context,
          details.globalPosition,
          commentModel: commentModel,
          userId: userId,
        );
      },
      child: ListTile(
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.5),
                child: CachedNetworkImage(
                  imageUrl: commentModel.userReviewModel.userImage,
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
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  commentModel.userReviewModel.userName,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                    DateFormat('MMMM d, y - H:mm')
                        .format(
                            DateTime.parse(commentModel.createdAt).toLocal())
                        .toString(), // Добавляем время
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                    )),
              ],
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Comment text
            const SizedBox(height: 10),
            Text(
              commentModel.comment,
              style: context.textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),

            /// Reactions
            if (commentModel.likeCount > 0 && commentModel.dislikeCount > 0)
              Row(
                children: [
                  GestureDetector(
                    onTap: onTapLike,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: commentModel.hasLikedUser == true
                            ? context.colors.primary
                            : context.colors.inversePrimary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 3,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.thumb_up,
                              color: context.colors.secondary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${commentModel.likeCount}',
                              style: context.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: onTapDislike,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: commentModel.hasLikedUser == false
                            ? context.colors.primary
                            : context.colors.inversePrimary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 3,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.thumb_down,
                              color: context.colors.secondary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${commentModel.dislikeCount}',
                              style: context.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (commentModel.likeCount > 0 && commentModel.dislikeCount == 0)
              Row(
                children: [
                  GestureDetector(
                    onTap: onTapLike,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: commentModel.hasLikedUser == true
                            ? context.colors.primary
                            : context.colors.inversePrimary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 3,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.thumb_up,
                              color: context.colors.secondary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${commentModel.likeCount}',
                              style: context.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (commentModel.likeCount == 0 && commentModel.dislikeCount > 0)
              Row(
                children: [
                  GestureDetector(
                    onTap: onTapDislike,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: commentModel.hasLikedUser == false
                            ? context.colors.primary
                            : context.colors.inversePrimary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 3,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.thumb_down,
                              color: context.colors.secondary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${commentModel.dislikeCount}',
                              style: context.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
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
