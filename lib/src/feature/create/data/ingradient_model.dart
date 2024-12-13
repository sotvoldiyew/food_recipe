

// To parse this JSON data, do
//
//     final ingradientModel = ingradientModelFromJson(jsonString);

import 'dart:convert';

IngradientModel ingradientModelFromJson(String str) => IngradientModel.fromJson(json.decode(str));

String ingradientModelToJson(IngradientModel data) => json.encode(data.toJson());

class IngradientModel {
  final bool? status;
  final List<IngredientItem>? data;
  final String? text;

  IngradientModel({
    this.status,
    this.data,
    this.text,
  });

  IngradientModel copyWith({
    bool? status,
    List<IngredientItem>? data,
    String? text,
  }) =>
      IngradientModel(
        status: status ?? this.status,
        data: data ?? this.data,
        text: text ?? this.text,
      );

  factory IngradientModel.fromJson(Map<String, dynamic> json) => IngradientModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<IngredientItem>.from(json["data"]!.map((x) => IngredientItem.fromJson(x))),
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "text": text,
  };
}

class IngredientItem {
  final int? id;
  final String? icon;
  final String? name;

  IngredientItem({
    this.id,
    this.icon,
    this.name,
  });

  IngredientItem copyWith({
    int? id,
    String? icon,
    String? name,
  }) =>
      IngredientItem(
        id: id ?? this.id,
        icon: icon ?? this.icon,
        name: name ?? this.name,
      );

  factory IngredientItem.fromJson(Map<String, dynamic> json) => IngredientItem(
    id: json["id"],
    icon: json["icon"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "icon": icon,
    "name": name,
  };
}
