class UpdateAccountRequest {
  final String username;
  final String displayName;
  final String? phoneNumber;
  final String? email;
  final DateTime? birthDate;

  UpdateAccountRequest({
    required this.username,
    required this.displayName,
    this.phoneNumber,
    this.email,
    this.birthDate,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'displayName': displayName,
    if (phoneNumber != null) 'phoneNumber': phoneNumber,
    if (email != null) 'email': email,
    if (birthDate != null) 'birthDate': birthDate?.toIso8601String(),
  };
}
