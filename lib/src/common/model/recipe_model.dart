class RecipeModel {
  final int id;
  final String title;
  final String? imgUrl;
  final String cookingTime;
  final double averageRating;

  RecipeModel({
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.cookingTime,
    required this.averageRating,
  });

  factory RecipeModel.fromJson(Map<String, Object?> json) {
    return RecipeModel(
      id: json['id'] as int,
      title: json['title'] as String,
      imgUrl: json['imgUrl'] as String?,
      cookingTime: json['cookingTime'] as String,
      averageRating: json['averageRating'] as double,
    );
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    imgUrl,
    cookingTime,
    averageRating,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecipeModel &&
        other.id == id &&
        other.title == title &&
        other.imgUrl == imgUrl &&
        other.cookingTime == cookingTime &&
        other.averageRating == averageRating;
  }


  @override
  String toString() {
    return "RecipeModel(id: $id, title: $title, imgUrl: $imgUrl, cookingTime: $cookingTime, averageRating: $averageRating)";
  }
}
