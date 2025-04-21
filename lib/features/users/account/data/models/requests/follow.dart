class Follow {
  final String userId;
  Follow({required this.userId});

  Map<String, dynamic> toJson() => {
    'userId': userId,
  };
}