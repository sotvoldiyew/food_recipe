class UserReviewModel {
  int userId;
  String userName;
  String userImage;

  UserReviewModel({
    required this.userId,
    required this.userName,
    required this.userImage,
  });

  factory UserReviewModel.fromJson(Map<String, Object?> json) {
    return UserReviewModel(
      userId: json['userId'] as int,
      userName: json['fullname'] as String,
      userImage: json['imageurl'] as String? ?? "",
    );
  }

  Map<String, Object?> toJson() {
    return {
      'userId': userId,
      'fullname': userName,
      'imageurl': userImage,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is UserReviewModel &&
        other.userId == userId &&
        other.userName == userName &&
        other.userImage == userImage;
  }

  @override
  int get hashCode => Object.hash(
    userId,
    userName,
    userImage,
  );

  @override
  String toString() {
    return 'UserReviewModel{userId: $userId, userName: $userName, userImage: $userImage}';
  }
}