import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/model/comment_model.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/reviews/controller/review_body_controller.dart';
import 'package:food_recipe/src/feature/reviews/screen/widgets/comment.dart';

import '../../bloc/review_bloc.dart';

class ReviewBody extends StatefulWidget {
  const ReviewBody({
    super.key,
    required this.comments,
    required this.recipeId,
  });

  final List<CommentModel> comments;
  final int recipeId;

  @override
  State<ReviewBody> createState() => _ReviewBodyState();
}

class _ReviewBodyState extends State<ReviewBody> with ReviewBodyController {

  @override
  Widget build(BuildContext context) {
    if (widget.comments.isEmpty) {
      return Center(
        child: Text(
          context.lang.no_comments,
          style: context.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      );
    } else {
      return BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, state) => Scaffold(
          backgroundColor: context.colors.onPrimary,
          body: ListView.builder(
            itemCount: widget.comments.length,
            itemBuilder: (context, index) {
              final commentModel = widget.comments[index];
              return Comment(
                commentModel: commentModel,
                userId: state.userId,
                onTapLike: () => onTapLike(commentModel: commentModel),
                onTapDislike: () => onTapDislike(commentModel: commentModel),
                onLongPressDown: showReactionMenu,
              );
            },
          ),
        ),
      );
    }
  }
}
