import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/reviews/bloc/review_bloc.dart';
import 'package:food_recipe/src/feature/reviews/controller/review_controller.dart';
import 'package:food_recipe/src/feature/reviews/screen/widgets/review_body.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> with ReviewController {

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
                  recipeId: state.recipeId,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
