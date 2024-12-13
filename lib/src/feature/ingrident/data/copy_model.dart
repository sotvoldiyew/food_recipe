// To parse this JSON data, do
//
//     final copyLink = copyLinkFromJson(jsonString);

import 'dart:convert';

CopyLink copyLinkFromJson(String str) => CopyLink.fromJson(json.decode(str));

String copyLinkToJson(CopyLink data) => json.encode(data.toJson());

class CopyLink {
  final bool? status;
  final Data2? data;
  final String? text;

  CopyLink({
    this.status,
    this.data,
    this.text,
  });

  CopyLink copyWith({
    bool? status,
    Data2? data,
    String? text,
  }) =>
      CopyLink(
        status: status ?? this.status,
        data: data ?? this.data,
        text: text ?? this.text,
      );

  factory CopyLink.fromJson(Map<String, dynamic> json) => CopyLink(
    status: json["status"],
    data: json["data"] == null ? null : Data2.fromJson(json["data"]),
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
    "text": text,
  };
}

class Data2 {
  final String? link;
  final dynamic averageReiting;
  final dynamic viewCount;

  Data2({
    this.link,
    this.averageReiting,
    this.viewCount,
  });

  Data2 copyWith({
    String? link,
    dynamic averageReiting,
    dynamic viewCount,
  }) =>
      Data2(
        link: link ?? this.link,
        averageReiting: averageReiting ?? this.averageReiting,
        viewCount: viewCount ?? this.viewCount,
      );

  factory Data2.fromJson(Map<String, dynamic> json) => Data2(
    link: json["link"],
    averageReiting: json["averageReiting"],
    viewCount: json["viewCount"],
  );

  Map<String, dynamic> toJson() => {
    "link": link,
    "averageReiting": averageReiting,
    "viewCount": viewCount,
  };
}
