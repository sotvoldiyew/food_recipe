

import 'dart:convert';

IngedientModel ingedientModelFromJson(String str) => IngedientModel.fromJson(json.decode(str));

String ingedientModelToJson(IngedientModel data) => json.encode(data.toJson());

class IngedientModel {
  final bool? status;
  final List<Datum2>? data;
  final String? text;

  IngedientModel({
    this.status,
    this.data,
    this.text,
  });

  IngedientModel copyWith({
    bool? status,
    List<Datum2>? data,
    String? text,
  }) =>
      IngedientModel(
        status: status ?? this.status,
        data: data ?? this.data,
        text: text ?? this.text,
      );

  factory IngedientModel.fromJson(Map<String, dynamic> json) => IngedientModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum2>.from(json["data"]!.map((x) => Datum2.fromJson(x))),
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "text": text,
  };
}

class Datum2 {
  final String? quantity;
  final String? icon;
  final String? name;

  Datum2({
    this.quantity,
    this.icon,
    this.name,
  });

  Datum2 copyWith({
    String? quantity,
    String? icon,
    String? name,
  }) =>
      Datum2(
        quantity: quantity ?? this.quantity,
        icon: icon ?? this.icon,
        name: name ?? this.name,
      );

  factory Datum2.fromJson(Map<String, dynamic> json) => Datum2(
    quantity: json["quantity"],
    icon: json["icon"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
    "icon": icon,
    "name": name,
  };
}
