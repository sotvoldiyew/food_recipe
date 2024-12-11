class VerificationRequest {
  final String email;
  final String code;

  VerificationRequest({
    required this.email,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "email": email,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VerificationRequest &&
        other.email == email &&
        other.code == code;
  }

  @override
  int get hashCode {
    return email.hashCode ^ code.hashCode;
  }
}
