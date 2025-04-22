import 'package:flutter/material.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/friendItem.dart';

class FriendsList extends StatelessWidget {
  final List<PublicBaseAccountResponse> friends;
  final Function(int)? onUnfollow;
  final String searchQuery;

  const FriendsList({
    super.key,
    required this.friends,
    required this.searchQuery,
    this.onUnfollow,
  });

  @override
  Widget build(BuildContext context) {
    final filteredFriends = friends.where((friend) {
      final name = friend.displayName.toLowerCase();
      final username = friend.username.toLowerCase();
      return name.contains(searchQuery.toLowerCase()) ||
          username.contains(searchQuery.toLowerCase());
    }).toList();

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
        itemCount: filteredFriends.length,
        itemBuilder: (context, index) {
          return FriendItem(
            friend: filteredFriends[index],
            onUnfollow: () {
              if (onUnfollow != null) {
                onUnfollow!(index);
              }
            },
          );
        },
      )
    );
  }
}