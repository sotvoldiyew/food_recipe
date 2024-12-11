
import 'dart:convert';

ProfileContent profileContentFromJson(String str) => ProfileContent.fromJson(json.decode(str));

String profileContentToJson(ProfileContent data) => json.encode(data.toJson());

class ProfileContent {
  final bool? status;
  final List<Datum>? data;
  final String? text;

  ProfileContent({
    this.status,
    this.data,
    this.text,
  });

  ProfileContent copyWith({
    bool? status,
    List<Datum>? data,
    String? text,
  }) =>
      ProfileContent(
        status: status ?? this.status,
        data: data ?? this.data,
        text: text ?? this.text,
      );

  factory ProfileContent.fromJson(Map<String, dynamic> json) => ProfileContent(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "text": text,
  };
}

class Datum {
  final int? id;
  final String? title;
  final String? description;
  final String? author;
  final String? time;
  final double? averageRating;
  final String? imageUrl;

  Datum({
    this.id,
    this.title,
    this.description,
    this.author,
    this.time,
    this.averageRating,
    this.imageUrl,
  });

  Datum copyWith({
    int? id,
    String? title,
    String? description,
    String? author,
    String? time,
    double? averageRating,
    String? imageUrl,
  }) =>
      Datum(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        author: author ?? this.author,
        time: time ?? this.time,
        averageRating: averageRating ?? this.averageRating,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    author: json["author"],
    time: json["time"],
    averageRating: json["averageRating"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "author": author,
    "time": time,
    "averageRating": averageRating,
    "imageUrl": imageUrl,
  };
}
