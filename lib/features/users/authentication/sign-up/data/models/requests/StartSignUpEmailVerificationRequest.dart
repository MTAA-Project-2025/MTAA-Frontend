class StartSignUpEmailVerificationRequest {
  final String email;

  StartSignUpEmailVerificationRequest({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}