// To parse this JSON data, do
//
//     final postRecipeModel = postRecipeModelFromJson(jsonString);

import 'dart:convert';

PostRecipeModel postRecipeModelFromJson(String str) => PostRecipeModel.fromJson(json.decode(str));

String postRecipeModelToJson(PostRecipeModel data) => json.encode(data.toJson());

class PostRecipeModel {
  final String? title;
  final String? description;
  final int? categoryId;
  final String? cookingTime;
  final String? videoUrl;
  final List<IngredientList>? ingredientList;
  final List<StepsList>? stepsList;

  PostRecipeModel({
    this.title,
    this.description,
    this.categoryId,
    this.cookingTime,
    this.videoUrl,
    this.ingredientList,
    this.stepsList,
  });

  PostRecipeModel copyWith({
    String? title,
    String? description,
    int? categoryId,
    String? cookingTime,
    String? videoUrl,
    List<IngredientList>? ingredientList,
    List<StepsList>? stepsList,
  }) =>
      PostRecipeModel(
        title: title ?? this.title,
        description: description ?? this.description,
        categoryId: categoryId ?? this.categoryId,
        cookingTime: cookingTime ?? this.cookingTime,
        videoUrl: videoUrl ?? this.videoUrl,
        ingredientList: ingredientList ?? this.ingredientList,
        stepsList: stepsList ?? this.stepsList,
      );

  factory PostRecipeModel.fromJson(Map<String, dynamic> json) => PostRecipeModel(
    title: json["title"],
    description: json["description"],
    categoryId: json["category_id"],
    cookingTime: json["cookingTime"],
    videoUrl: json["videoUrl"],
    ingredientList: json["ingredientList"] == null ? [] : List<IngredientList>.from(json["ingredientList"]!.map((x) => IngredientList.fromJson(x))),
    stepsList: json["stepsList"] == null ? [] : List<StepsList>.from(json["stepsList"]!.map((x) => StepsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "category_id": categoryId,
    "cookingTime": cookingTime,
    "videoUrl": videoUrl,
    "ingredientList": ingredientList == null ? [] : List<dynamic>.from(ingredientList!.map((x) => x.toJson())),
    "stepsList": stepsList == null ? [] : List<dynamic>.from(stepsList!.map((x) => x.toJson())),
  };
}

class IngredientList {
  final int? ingredientId;
  final String? ingredientQuantity;

  IngredientList({
    this.ingredientId,
    this.ingredientQuantity,
  });

  IngredientList copyWith({
    int? ingredientId,
    String? ingredientQuantity,
  }) =>
      IngredientList(
        ingredientId: ingredientId ?? this.ingredientId,
        ingredientQuantity: ingredientQuantity ?? this.ingredientQuantity,
      );

  factory IngredientList.fromJson(Map<String, dynamic> json) => IngredientList(
    ingredientId: json["ingredientId"],
    ingredientQuantity: json["ingredientQuantity"],
  );

  Map<String, dynamic> toJson() => {
    "ingredientId": ingredientId,
    "ingredientQuantity": ingredientQuantity,
  };
}

class StepsList {
  final String? text;
  final int? stepNumber;

  StepsList({
    this.text,
    this.stepNumber,
  });

  StepsList copyWith({
    String? text,
    int? stepNumber,
  }) =>
      StepsList(
        text: text ?? this.text,
        stepNumber: stepNumber ?? this.stepNumber,
      );

  factory StepsList.fromJson(Map<String, dynamic> json) => StepsList(
    text: json["text"],
    stepNumber: json["step_number"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "step_number": stepNumber,
  };
}
