
import 'dart:convert';

StepsModel stepsModelFromJson(String str) => StepsModel.fromJson(json.decode(str));

String stepsModelToJson(StepsModel data) => json.encode(data.toJson());

class StepsModel {
  final bool? status;
  final List<Datumm>? data;
  final String? text;

  StepsModel({
    this.status,
    this.data,
    this.text,
  });

  StepsModel copyWith({
    bool? status,
    List<Datumm>? data,
    String? text,
  }) =>
      StepsModel(
        status: status ?? this.status,
        data: data ?? this.data,
        text: text ?? this.text,
      );

  factory StepsModel.fromJson(Map<String, dynamic> json) => StepsModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datumm>.from(json["data"]!.map((x) => Datumm.fromJson(x))),
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "text": text,
  };
}

class Datumm {
  final int? stepId;
  final String? text;
  final int? stepNumber;
  final int? recipeId;

  Datumm({
    this.stepId,
    this.text,
    this.stepNumber,
    this.recipeId,
  });

  Datumm copyWith({
    int? stepId,
    String? text,
    int? stepNumber,
    int? recipeId,
  }) =>
      Datumm(
        stepId: stepId ?? this.stepId,
        text: text ?? this.text,
        stepNumber: stepNumber ?? this.stepNumber,
        recipeId: recipeId ?? this.recipeId,
      );

  factory Datumm.fromJson(Map<String, dynamic> json) => Datumm(
    stepId: json["stepId"],
    text: json["text"],
    stepNumber: json["stepNumber"],
    recipeId: json["recipeId"],
  );

  Map<String, dynamic> toJson() => {
    "stepId": stepId,
    "text": text,
    "stepNumber": stepNumber,
    "recipeId": recipeId,
  };
}
