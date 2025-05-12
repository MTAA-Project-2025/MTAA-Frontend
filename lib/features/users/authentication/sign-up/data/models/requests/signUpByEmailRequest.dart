class SignUpByEmailRequest {
  final String email;
  final String username;
  final String password;

  SignUpByEmailRequest({required this.email, required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'password': password,
    };
  }
}