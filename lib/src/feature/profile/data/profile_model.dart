import 'package:meta/meta.dart';

@immutable
class UserProfile {
  final bool status;
  final UserData? data;
  final String text;

  const UserProfile({
    required this.status,
    required this.data,
    required this.text,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      status: json['status'] as bool,
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      text: json['text'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data?.toJson(),
    'text': text,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserProfile) return false;
    return status == other.status &&
        data == other.data &&
        text == other.text;
  }

  @override
  int get hashCode => Object.hash(status, data, text);
}

@immutable
class UserData {
  final int userId;
  final int recipeNumber;
  final int followersCount;
  final int followingCount;
  final String userName;
  final String userRole;
  final String? description;
  final String? authorImg;

  const UserData({
    required this.userId,
    required this.recipeNumber,
    required this.followersCount,
    required this.followingCount,
    required this.userName,
    required this.userRole,
    this.description,
    this.authorImg,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['userId'] as int,
      recipeNumber: json['recipeNumber'] as int,
      followersCount: json['followersCount'] as int,
      followingCount: json['followingCount'] as int,
      userName: json['userName'] as String,
      userRole: json['userRole'] as String,
      description: json['description'] as String?,
      authorImg: json['authorImg'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'recipeNumber': recipeNumber,
    'followersCount': followersCount,
    'followingCount': followingCount,
    'userName': userName,
    'userRole': userRole,
    'description': description,
    'authorImg': authorImg,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserData) return false;
    return userId == other.userId &&
        recipeNumber == other.recipeNumber &&
        followersCount == other.followersCount &&
        followingCount == other.followingCount &&
        userName == other.userName &&
        userRole == other.userRole &&
        description == other.description &&
        authorImg == other.authorImg;
  }

  @override
  int get hashCode => Object.hash(
    userId,
    recipeNumber,
    followersCount,
    followingCount,
    userName,
    userRole,
    description,
    authorImg,
  );
}
