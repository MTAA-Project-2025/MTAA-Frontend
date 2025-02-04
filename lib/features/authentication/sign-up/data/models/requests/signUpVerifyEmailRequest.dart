class SignUpVerifyEmailRequest {
  final String email;
  final String code;

  SignUpVerifyEmailRequest({required this.email, required this.code});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'code': code,
    };
  }
}