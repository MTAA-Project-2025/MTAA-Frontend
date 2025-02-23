class LogInRequest {
  final String? email;
  final String? phone;
  final String password;

  LogInRequest({required this.email, required this.phone, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'password': password,
    };
  }
}