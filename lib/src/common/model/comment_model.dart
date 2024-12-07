class CommentModel {
  String comment;
  int recipeId;

  CommentModel({
    required this.comment,
    required this.recipeId,
  });

  factory CommentModel.fromJson(Map<String, Object?> json) {
    return CommentModel(
      comment: json["comment"] as String,
      recipeId: json["recipeId"] as int,
    );
  }

  @override
  int get hashCode => Object.hash(comment, recipeId); // 20

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is CommentModel) {
      return runtimeType == other.runtimeType &&
          comment == other.comment &&
          recipeId == other.recipeId;
    }

    return false;
  }

  @override
  String toString() {
    return "CommentModel(comment: $comment, recipeId: $recipeId)\n";
  }
}
