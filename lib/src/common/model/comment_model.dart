class CommentModel {
  String text;
  String author;
  DateTime time;
  int commentId;

  CommentModel({
    required this.text,
    required this.author,
    required this.commentId,
    required this.time,
  });

  factory CommentModel.fromJson(Map<String, Object?> json) {
    return CommentModel(
      text: json["text"] as String,
      author: json["author"] as String,
      commentId: json["commentId"] as int,
      time: DateTime.parse(json["time"] as String),
    );
  }

  @override
  int get hashCode => Object.hash(text, author, commentId, time); // 20

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is CommentModel) {
      return runtimeType == other.runtimeType &&
          text == other.text &&
          author == other.author &&
          time == other.time;
    }

    return false;
  }

  @override
  String toString() {
    return "CommentModel(text: $text, author: $author, commentId: $commentId, time: $time)\n";
  }
}
