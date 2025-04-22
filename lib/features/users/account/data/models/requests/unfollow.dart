class Unfollow {
  final String userId;
  Unfollow({required this.userId});

  Map<String, dynamic> toJson() => {
    'targetUserId': userId,
  };
}