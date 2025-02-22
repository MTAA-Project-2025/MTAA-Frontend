class UpdateAccountDisplayNameRequest {
  final String displayName;

  UpdateAccountDisplayNameRequest({required this.displayName});

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
    };
  }
}