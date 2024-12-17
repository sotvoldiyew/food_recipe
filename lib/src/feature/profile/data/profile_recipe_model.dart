// To parse this JSON data, do
//
//     final reciepeModel = reciepeModelFromJson(jsonString);

import 'dart:convert';

import 'package:food_recipe/src/common/model/recipe_model.dart';

ReciepeFullModel reciepeFullModelFromJson(String str) => ReciepeFullModel.fromJson(json.decode(str));


class ReciepeFullModel {
  final bool? status;
  final List<RecipeModel>? data;
  final String? text;

  ReciepeFullModel({
    this.status,
    this.data,
    this.text,
  });

  ReciepeFullModel copyWith({
    bool? status,
    List<RecipeModel>? data,
    String? text,
  }) =>
      ReciepeFullModel(
        status: status ?? this.status,
        data: data ?? this.data,
        text: text ?? this.text,
      );

  factory ReciepeFullModel.fromJson(Map<String, dynamic> json) => ReciepeFullModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<RecipeModel>.from(json["data"]!.map((x) => RecipeModel.fromJson(x))),
    text: json["text"],
  );


}


class Category {
  final int? id;
  final String? name;

  Category({
    this.id,
    this.name,
  });

  Category copyWith({
    int? id,
    String? name,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
