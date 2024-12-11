import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/model/comment_model.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/reviews/screen/widgets/comment.dart';

import '../../bloc/review_bloc.dart';

class ReviewBody extends StatelessWidget {
  const ReviewBody({super.key, required this.comments});

  final List<CommentModel> comments;

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
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
          body:  ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final commentModel = comments[index];
              return Comment(
                comment: commentModel.comment,
                ownerImage: commentModel.userReviewModel.userImage,
                likeCount: commentModel.likeCount,
                dislikeCount: commentModel.dislikeCount,
                ownerName: commentModel.userReviewModel.userName,
                time: commentModel.createdAt,
                hasReaction: commentModel.hasLikedUser,
                onTapLike: () {},
                onTapDislike: () {},
                onPressed: () {
                  context.read<ReviewBloc>().add(
                    GetReviews$ReviewEvent(
                      context: context,
                      recipeId: 1,
                      userId: 5,
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    }
  }
}
