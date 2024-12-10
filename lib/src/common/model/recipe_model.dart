class RecipeModel {
  final int id;
  final String title;
  final String? imgUrl;
  final String cookingTime;
  final double averageRating;
  final String? ownerImage;
  final String? ownerName;
  final int? ownerId;

  RecipeModel({
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.cookingTime,
    required this.averageRating,
    required this.ownerImage,
    required this.ownerName,
    required this.ownerId,
  });

  factory RecipeModel.fromJson(Map<String, Object?> json) {
    return RecipeModel(
      id: json['id'] as int,
      title: json['title'] as String,
      imgUrl: json['imgUrl'] as String?,
      cookingTime: json['cookingTime'] as String,
      averageRating: json['averageRating'] as double,
      ownerImage: json['ownerImage'] as String?,
      ownerName: json['ownerName'] as String?,
      ownerId: json['ownerId'] as int?,
    );
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    imgUrl,
    cookingTime,
    averageRating,
    ownerImage,
    ownerName,
    ownerId,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecipeModel &&
        other.id == id &&
        other.title == title &&
        other.imgUrl == imgUrl &&
        other.cookingTime == cookingTime &&
        other.averageRating == averageRating &&
        other.ownerImage == ownerImage &&
        other.ownerName == ownerName &&
        other.ownerId == ownerId;
  }


  @override
  String toString() {
    return "RecipeModel(id: $id, title: $title, imgUrl: $imgUrl, cookingTime: $cookingTime, averageRating: $averageRating, ownerImage: $ownerImage, ownerName: $ownerName, ownerId: $ownerId)";
  }
}
