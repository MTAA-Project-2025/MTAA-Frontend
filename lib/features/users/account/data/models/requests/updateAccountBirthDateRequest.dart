class UpdateAccountBirthDateRequest {
  final DateTime birthDate;

  UpdateAccountBirthDateRequest({required this.birthDate});

  Map<String, dynamic> toJson() {
    return {
      'birthDate': birthDate.toIso8601String(),
    };
  }
}