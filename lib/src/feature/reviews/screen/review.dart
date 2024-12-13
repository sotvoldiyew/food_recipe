import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/reviews/bloc/review_bloc.dart';
import 'package:food_recipe/src/feature/reviews/controller/review_controller.dart';
import 'package:food_recipe/src/feature/reviews/screen/widgets/comment.dart';
import 'package:food_recipe/src/feature/reviews/screen/widgets/review_body.dart';

import "package:intl/intl.dart";

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> with ReviewController {

  // void _addComment() {
  //   if (commentController.text.isNotEmpty) {
  //     setState(() {
  //       comments.add({
  //         'name': 'You', // Ваше имя или идентификатор
  //         'text': commentController.text,
  //         'time': _getCurrentTime(), // Добавляем текущее время
  //       });
  //       commentController.clear();
  //     });
  //   }
  // }
  //
  // void _react(int commentId, String reaction) {
  //   setState(() {
  //     if (userReactions.containsKey(commentId)) {
  //       if (userReactions[commentId] == reaction) {
  //         userReactions.remove(commentId);
  //         if (reaction == 'Like') {
  //           likesCount[commentId] = (likesCount[commentId] ?? 1) - 1;
  //         } else if (reaction == 'Dislike') {
  //           dislikesCount[commentId] = (dislikesCount[commentId] ?? 1) - 1;
  //         }
  //       } else {
  //         if (userReactions[commentId] == 'Like') {
  //           likesCount[commentId] = (likesCount[commentId] ?? 1) - 1;
  //         } else if (userReactions[commentId] == 'Dislike') {
  //           dislikesCount[commentId] = (dislikesCount[commentId] ?? 1) - 1;
  //         }
  //
  //         userReactions[commentId] = reaction;
  //         if (reaction == 'Like') {
  //           likesCount[commentId] = (likesCount[commentId] ?? 0) + 1;
  //         } else if (reaction == 'Dislike') {
  //           dislikesCount[commentId] = (dislikesCount[commentId] ?? 0) + 1;
  //         }
  //       }
  //     } else {
  //       userReactions[commentId] = reaction;
  //       if (reaction == 'Like') {
  //         likesCount[commentId] = (likesCount[commentId] ?? 0) + 1;
  //       } else if (reaction == 'Dislike') {
  //         dislikesCount[commentId] = (dislikesCount[commentId] ?? 0) + 1;
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          context.lang.reviews,
          style: context.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: commentController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1.5,
                    color: context.colors.outlineVariant,
                  ),
                ),
                hintText: context.lang.say_something,
                hintStyle: context.textTheme.titleMedium?.copyWith(
                  color: context.colors.outlineVariant,
                ),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(
                    width: 1.5,
                    color: context.colors.outlineVariant,
                  ),
                ),
                suffixIcon: Padding(
                  // Кнопка отправить комментарии
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child: FilledButton(
                    onPressed: () {
                      context.read<ReviewBloc>().add(
                            SendMessage$ReviewEvent(
                              text: commentController.text,
                              context: context,
                            ),
                          );
                    },
                    style: const ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    child: Text(context.lang.send),
                  ),
                ),
              ),
            ),
          ),

          /// Comments
          Expanded(
            child: BlocBuilder<ReviewBloc, ReviewState>(
              builder: (context, state) {
                return ReviewBody(
                  comments: state.comments,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _showReactionMenu(BuildContext context, Offset position) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        100,
        position.dy - 40, // Смещение вверх
        position.dx,
        100,
      ),
      items: [
        PopupMenuItem(
          enabled: true, // Делаем элемент меню кастомным
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Закрыть меню
                  print('👍');
                },
                child: const Text('👍', style: TextStyle(fontSize: 24)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  print('👎');
                },
                child: const Text('👎', style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
