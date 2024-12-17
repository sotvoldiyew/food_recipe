import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/reviews/screen/widgets/review_body.dart';

import '../../../common/model/comment_model.dart';
import '../bloc/review_bloc.dart';

mixin ReviewBodyController on State<ReviewBody> {
  void showReactionMenu(BuildContext context, Offset position, {required CommentModel commentModel, required int userId}) {
    showMenu(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: context.colors.outlineVariant),
      ),
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy - 40, // Смещение вверх
        position.dx,
        position.dy + 40, // Смещение вниз
      ),
      items: [
        PopupMenuItem(
          enabled: true, // Делаем элемент меню кастомным
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Закрыть меню
                  onTapLike(commentModel: commentModel);
                },
                child: Icon(Icons.thumb_up, color: context.colors.secondary),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  onTapDislike(commentModel: commentModel);
                },
                child: Icon(Icons.thumb_down, color: context.colors.secondary),
              ),
            ],
          ),
        ),
        if (userId == commentModel.userReviewModel.userId) PopupMenuItem(
          enabled: true,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  onTapDelete(commentModel: commentModel);
                },
                child: Icon(Icons.delete, color: context.colors.error),
              ),
              const SizedBox(width: 5),
              Text(
                context.lang.delete,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.error,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onTapLike({required CommentModel commentModel}) {
    context.read<ReviewBloc>().add(
          Emoji$ReviewEvent(
            context: context,
            emoji: true,
            userId: commentModel.userReviewModel.userId,
            reviewId: commentModel.reviewId,
          ),
        );
  }

  void onTapDislike({required CommentModel commentModel}) {
    context.read<ReviewBloc>().add(
          Emoji$ReviewEvent(
            context: context,
            emoji: false,
            userId: commentModel.userReviewModel.userId,
            reviewId: commentModel.reviewId,
          ),
        );
  }

  void onTapDelete({required CommentModel commentModel}) {
    context.read<ReviewBloc>().add(
          DeleteComment$ReviewEvent(
            context: context,
            commentId: commentModel.reviewId,
          ),
        );
  }
}
