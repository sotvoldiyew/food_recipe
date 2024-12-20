
import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  final bool? status;
  final List<Datum10>? data;
  final String? text;

  NotificationModel({
    this.status,
    this.data,
    this.text,
  });

  NotificationModel copyWith({
    bool? status,
    List<Datum10>? data,
    String? text,
  }) =>
      NotificationModel(
        status: status ?? this.status,
        data: data ?? this.data,
        text: text ?? this.text,
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum10>.from(json["data"]!.map((x) => Datum10.fromJson(x))),
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "text": text,
  };
}

class Datum10 {
  final int? userId;
  final int? recipeId;
  final Title? title;
  final String? text;
  final bool? hasRead;
  final DateTime? createdAt;

  Datum10({
    this.userId,
    this.recipeId,
    this.title,
    this.text,
    this.hasRead,
    this.createdAt,
  });

  Datum10 copyWith({
    int? userId,
    int? recipeId,
    Title? title,
    String? text,
    bool? hasRead,
    DateTime? createdAt,
  }) =>
      Datum10(
        userId: userId ?? this.userId,
        recipeId: recipeId ?? this.recipeId,
        title: title ?? this.title,
        text: text ?? this.text,
        hasRead: hasRead ?? this.hasRead,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Datum10.fromJson(Map<String, dynamic> json) => Datum10(
    userId: json["userId"],
    recipeId: json["recipeId"],
    title: titleValues.map[json["title"]]!,
    text: json["text"],
    hasRead: json["hasRead"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "recipeId": recipeId,
    "title": titleValues.reverse[title],
    "text": text,
    "hasRead": hasRead,
    "createdAt": createdAt?.toIso8601String(),
  };
}

enum Title {
  SAVED_RECIPE_ALERT
}

final titleValues = EnumValues({
  "Saved Recipe Alert": Title.SAVED_RECIPE_ALERT
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
