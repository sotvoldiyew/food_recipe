import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';

class Comment extends StatelessWidget {
  const Comment({
    super.key,
    required this.ownerImage,
    required this.ownerName,
    required this.time,
    required this.comment,
    required this.likeCount,
    required this.dislikeCount,
  });

  final String ownerImage;
  final String ownerName;
  final String time;
  final String comment;
  final int likeCount;
  final int dislikeCount;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: InkWell(
        onTap: () {},
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 20,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ownerName,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  time, // Добавляем время
                  style: TextStyle(
                    color: context.colors.outline,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(comment),
          const SizedBox(height: 10),
          // Row(
          //   children: [
          //     GestureDetector(
          //       onTap: () => _react(index, 'Like'),
          //       child: Row(
          //         children: [
          //           Icon(
          //             Icons.thumb_up,
          //             color: userReactions[index] == 'Like'
          //                 ? Colors.yellow
          //                 : Colors.grey,
          //           ),
          //           const SizedBox(width: 5),
          //           Text(
          //             '${likesCount[index] ?? 0}',
          //             style: TextStyle(
          //               color: userReactions[index] == 'Like'
          //                   ? Colors.yellow
          //                   : Colors.grey,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     const SizedBox(width: 20),
          //     GestureDetector(
          //       onTap: () => _react(index, 'Dislike'),
          //       child: Row(
          //         children: [
          //           Icon(
          //             Icons.thumb_down,
          //             color: userReactions[index] == 'Dislike'
          //                 ? Colors.yellow
          //                 : Colors.grey,
          //           ),
          //           const SizedBox(width: 5),
          //           Text(
          //             '${dislikesCount[index] ?? 0}',
          //             style: TextStyle(
          //               color: userReactions[index] == 'Dislike'
          //                   ? Colors.yellow
          //                   : Colors.grey,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
