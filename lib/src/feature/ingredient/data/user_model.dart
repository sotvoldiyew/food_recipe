
import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  final bool? status;
  final Data? data;
  final String? text;

  UserInfo({
    this.status,
    this.data,
    this.text,
  });

  UserInfo copyWith({
    bool? status,
    Data? data,
    String? text,
  }) =>
      UserInfo(
        status: status ?? this.status,
        data: data ?? this.data,
        text: text ?? this.text,
      );

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
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
  final int? userId;
  final int? recipeNumber;
  final int? followersCount;
  final int? followingCount;
  final String? userName;
  final String? userRole;
  final dynamic description;
  final dynamic authorImg;
  final String? country;
  final String? city;

  Data({
    this.userId,
    this.recipeNumber,
    this.followersCount,
    this.followingCount,
    this.userName,
    this.userRole,
    this.description,
    this.authorImg,
    this.country,
    this.city,
  });

  Data copyWith({
    int? userId,
    int? recipeNumber,
    int? followersCount,
    int? followingCount,
    String? userName,
    String? userRole,
    dynamic description,
    dynamic authorImg,
    String? country,
    String? city,
  }) =>
      Data(
        userId: userId ?? this.userId,
        recipeNumber: recipeNumber ?? this.recipeNumber,
        followersCount: followersCount ?? this.followersCount,
        followingCount: followingCount ?? this.followingCount,
        userName: userName ?? this.userName,
        userRole: userRole ?? this.userRole,
        description: description ?? this.description,
        authorImg: authorImg ?? this.authorImg,
        country: country ?? this.country,
        city: city ?? this.city,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["userId"],
    recipeNumber: json["recipeNumber"],
    followersCount: json["followersCount"],
    followingCount: json["followingCount"],
    userName: json["userName"],
    userRole: json["userRole"],
    description: json["description"],
    authorImg: json["authorImg"],
    country: json["country"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "recipeNumber": recipeNumber,
    "followersCount": followersCount,
    "followingCount": followingCount,
    "userName": userName,
    "userRole": userRole,
    "description": description,
    "authorImg": authorImg,
    "country": country,
    "city": city,
  };
}
