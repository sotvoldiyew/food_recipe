import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/reviews/bloc/review_bloc.dart';
import 'package:food_recipe/src/feature/reviews/controller/review_controller.dart';

import "package:intl/intl.dart";

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> with ReviewController {
  final Map<int, int> likesCount = {}; // Количество лайков
  final Map<int, int> dislikesCount = {}; // Количество дизлайков
  final Map<int, String> userReactions = {}; // Реакция пользователя
  final List<Map<String, String>> comments = [
    {
      'name': 'Bella Throne',
      'text': 'Lorem Ipsum dolor sit amet.',
      'time': 'June 12, 2020 - 19:35'
    },
    {
      'name': 'Christopher Oshana',
      'text': 'Consectetur adipiscing elit.',
      'time': 'June 12, 2020 - 19:35'
    },
    {
      'name': 'Kyle Austin',
      'text': 'Sed do eiusmod tempor incididunt.',
      'time': 'June 12, 2020 - 19:35'
    },
    {
      'name': 'Jeniffer Wilson',
      'text': 'Ut labore et dolore magna aliqua.',
      'time': 'June 12, 2020 - 19:35'
    },
    {
      'name': 'Kate Johnson',
      'text': 'Excepteur sint occaecat cupidatat.',
      'time': 'June 12, 2020 - 19:35'
    },
  ];

  // Форматируем текущее время
  String _getCurrentTime({String? time}) {
    final now = DateTime.now();
    final formatter =
        DateFormat('MMM d, y - H:mm'); // Формат времени (12:30 PM)
    return formatter.format(now);
  }

  void _addComment() {
    if (commentController.text.isNotEmpty) {
      setState(() {
        comments.add({
          'name': 'You', // Ваше имя или идентификатор
          'text': commentController.text,
          'time': _getCurrentTime(), // Добавляем текущее время
        });
        commentController.clear();
      });
    }
  }

  void _react(int commentId, String reaction) {
    setState(() {
      if (userReactions.containsKey(commentId)) {
        if (userReactions[commentId] == reaction) {
          userReactions.remove(commentId);
          if (reaction == 'Like') {
            likesCount[commentId] = (likesCount[commentId] ?? 1) - 1;
          } else if (reaction == 'Dislike') {
            dislikesCount[commentId] = (dislikesCount[commentId] ?? 1) - 1;
          }
        } else {
          if (userReactions[commentId] == 'Like') {
            likesCount[commentId] = (likesCount[commentId] ?? 1) - 1;
          } else if (userReactions[commentId] == 'Dislike') {
            dislikesCount[commentId] = (dislikesCount[commentId] ?? 1) - 1;
          }

          userReactions[commentId] = reaction;
          if (reaction == 'Like') {
            likesCount[commentId] = (likesCount[commentId] ?? 0) + 1;
          } else if (reaction == 'Dislike') {
            dislikesCount[commentId] = (dislikesCount[commentId] ?? 0) + 1;
          }
        }
      } else {
        userReactions[commentId] = reaction;
        if (reaction == 'Like') {
          likesCount[commentId] = (likesCount[commentId] ?? 0) + 1;
        } else if (reaction == 'Dislike') {
          dislikesCount[commentId] = (dislikesCount[commentId] ?? 0) + 1;
        }
      }
    });
  }

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
      body: BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, state) => Column(
          children: [
            if (!state.isCommented) // Поле для комментариев доступно только один раз
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
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
                      suffixIcon: Padding(// Кнопка отправить комментарии
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
              ),
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return InkWell(
                    onTapDown: (details) {
                      _showReactionMenu(context, details.globalPosition);
                    },
                    child: ListTile(
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
                                  comment['name']!,
                                  style:
                                      context.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  comment['time']!, // Добавляем время
                                  style: TextStyle(
                                      color: context.colors.outline,
                                      fontSize: 12),
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
                          Text(comment['text']!),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => _react(index, 'Like'),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.thumb_up,
                                      color: userReactions[index] == 'Like'
                                          ? Colors.yellow
                                          : Colors.grey,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '${likesCount[index] ?? 0}',
                                      style: TextStyle(
                                        color: userReactions[index] == 'Like'
                                            ? Colors.yellow
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () => _react(index, 'Dislike'),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.thumb_down,
                                      color: userReactions[index] == 'Dislike'
                                          ? Colors.yellow
                                          : Colors.grey,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '${dislikesCount[index] ?? 0}',
                                      style: TextStyle(
                                        color: userReactions[index] == 'Dislike'
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
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
