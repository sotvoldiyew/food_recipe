import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:intl/intl.dart';

import '../../../../common/style/app_images.dart';

class Comment extends StatelessWidget {
  const Comment({
    super.key,
    required this.ownerImage,
    required this.ownerName,
    required this.time,
    required this.comment,
    required this.likeCount,
    required this.dislikeCount,
    required this.onTapLike,
    required this.onTapDislike,
    required this.onPressed,
    this.hasReaction,
  });

  final String ownerImage;
  final String ownerName;
  final String time;
  final String comment;
  final int likeCount;
  final int dislikeCount;
  final void Function() onTapLike;
  final void Function() onTapDislike;
  final bool? hasReaction;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: InkWell(
        onTap: onPressed,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.5),
                child: CachedNetworkImage(
                  imageUrl: ownerImage,
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
                  ownerName,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  DateFormat('MMMM d, y - H:mm')
                      .format(DateTime.parse(time).toLocal())
                      .toString(), // Добавляем время
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  )
                ),
              ],
            ),
          ],
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Comment text
          const SizedBox(height: 10),
          Text(comment, style: context.textTheme.bodyLarge,),
          const SizedBox(height: 10),

          /// Reactions
          if (likeCount > 0 && dislikeCount > 0)
            Row(
              children: [
                GestureDetector(
                  onTap: onTapLike, // () => _react(index, true),
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color:
                            hasReaction == true ? Colors.yellow : Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$likeCount',
                        style: TextStyle(
                          color:
                              hasReaction == true ? Colors.yellow : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: onTapDislike,
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_down,
                        color:
                            hasReaction == false ? Colors.yellow : Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$dislikeCount',
                        style: TextStyle(
                          color: hasReaction == false
                              ? Colors.yellow
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          if (likeCount > 0 && dislikeCount == 0)
            Row(
              children: [
                GestureDetector(
                  onTap: onTapLike,
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color:
                            hasReaction == true ? Colors.yellow : Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$likeCount',
                        style: TextStyle(
                          color:
                              hasReaction == true ? Colors.yellow : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          if (likeCount == 0 && dislikeCount > 0)
            Row(
              children: [
                GestureDetector(
                  onTap: onTapDislike,
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_down,
                        color:
                            hasReaction == false ? Colors.yellow : Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$dislikeCount',
                        style: TextStyle(
                          color: hasReaction == false
                              ? Colors.yellow
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
