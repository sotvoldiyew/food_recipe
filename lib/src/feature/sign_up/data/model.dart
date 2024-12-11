class SignUpRequest {
  final String email;
  final String password;
  final String name;
  final String role;

  SignUpRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "role": role,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignUpRequest &&
        other.email == email &&
        other.password == password &&
        other.name == name &&
        other.role == role;
  }

  @override
  int get hashCode {
    return email.hashCode ^
    password.hashCode ^
    name.hashCode ^
    role.hashCode;
  }
}
