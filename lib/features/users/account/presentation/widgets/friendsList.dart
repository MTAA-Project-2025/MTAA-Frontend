import 'package:flutter/material.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/friendItem.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';

/// Widget displaying a list of friends with filtering by search query.
class FriendsList extends StatefulWidget {
  final List<PublicBaseAccountResponse> friends;
  final Function(int)? onUnfollow;
  final String searchQuery;
  final AccountRepository repository;
  final TokenStorage tokenStorage;

  /// Creates a [FriendsList] with required friends data and dependencies.
  const FriendsList({
    super.key,
    required this.friends,
    required this.searchQuery,
    this.onUnfollow,
    required this.repository,
    required this.tokenStorage,
  });

  @override
  State<FriendsList> createState() => _FriendsListState();
}

/// Manages the state for displaying filtered friends.
class _FriendsListState extends State<FriendsList> {
  /// Builds the UI with a scrollable list of friend items.
  @override
  Widget build(BuildContext context) {
    final filteredFriends = widget.friends.where((friend) {
      final name = friend.displayName.toLowerCase();
      final username = friend.username.toLowerCase();
      return name.contains(widget.searchQuery.toLowerCase()) || username.contains(widget.searchQuery.toLowerCase());
    }).toList();

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          itemCount: filteredFriends.length,
          itemBuilder: (context, index) {
            return FriendItem(
              friend: filteredFriends[index],
              repository: widget.repository,
              tokenStorage: widget.tokenStorage,
            );
          },
        ));
  }
}
