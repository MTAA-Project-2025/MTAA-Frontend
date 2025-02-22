class UpdateAccountUsernameRequest {
  final String username;

  UpdateAccountUsernameRequest({required this.username});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
    };
  }
}