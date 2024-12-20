// To parse this JSON data, do
//
//     final recipeInfo = recipeInfoFromJson(jsonString);

import 'dart:convert';

RecipeInfo recipeInfoFromJson(String str) => RecipeInfo.fromJson(json.decode(str));

String recipeInfoToJson(RecipeInfo data) => json.encode(data.toJson());

class RecipeInfo {
  final bool? status;
  final Data? data;
  final String? text;

  RecipeInfo({
    this.status,
    this.data,
    this.text,
  });

  RecipeInfo copyWith({
    bool? status,
    Data? data,
    String? text,
  }) =>
      RecipeInfo(
        status: status ?? this.status,
        data: data ?? this.data,
        text: text ?? this.text,
      );

  factory RecipeInfo.fromJson(Map<String, dynamic> json) => RecipeInfo(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
    "text": text,
  };
}

class Data {
  final int? id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? videoUrl;
  final String? author;
  final String? authorLocation;
  final dynamic authorImageUrl;
  final int? authorId;
  final dynamic isFollow;
  final bool? isSaved;
  final double? averageRating;
  final String? cookingTime;
  final int? viewCount;

  Data({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.videoUrl,
    this.author,
    this.authorLocation,
    this.authorImageUrl,
    this.authorId,
    this.isFollow,
    this.isSaved,
    this.averageRating,
    this.cookingTime,
    this.viewCount,
  });

  Data copyWith({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    String? videoUrl,
    String? author,
    String? authorLocation,
    dynamic authorImageUrl,
    int? authorId,
    dynamic isFollow,
    bool? isSaved,
    double? averageRating,
    String? cookingTime,
    int? viewCount,
  }) =>
      Data(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        videoUrl: videoUrl ?? this.videoUrl,
        author: author ?? this.author,
        authorLocation: authorLocation ?? this.authorLocation,
        authorImageUrl: authorImageUrl ?? this.authorImageUrl,
        authorId: authorId ?? this.authorId,
        isFollow: isFollow ?? this.isFollow,
        isSaved: isSaved ?? this.isSaved,
        averageRating: averageRating ?? this.averageRating,
        cookingTime: cookingTime ?? this.cookingTime,
        viewCount: viewCount ?? this.viewCount,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    videoUrl: json["videoUrl"],
    author: json["author"],
    authorLocation: json["authorLocation"],
    authorImageUrl: json["authorImageUrl"],
    authorId: json["authorId"],
    isFollow: json["isFollow"],
    isSaved: json["isSaved"],
    averageRating: json["averageRating"],
    cookingTime: json["cookingTime"],
    viewCount: json["viewCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "imageUrl": imageUrl,
    "videoUrl": videoUrl,
    "author": author,
    "authorLocation": authorLocation,
    "authorImageUrl": authorImageUrl,
    "authorId": authorId,
    "isFollow": isFollow,
    "isSaved": isSaved,
    "averageRating": averageRating,
    "cookingTime": cookingTime,
    "viewCount": viewCount,
  };
}
