import 'package:flutter/material.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/follow.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/unfollow.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/friendItem.dart';

class FriendsList extends StatefulWidget {
  final List<PublicBaseAccountResponse> friends;
  final Function(int)? onUnfollow;
  final String searchQuery;
  final AccountRepository repository; 

  const FriendsList({
    super.key,
    required this.friends,
    required this.searchQuery,
    this.onUnfollow,
    required this.repository,
  });

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    final filteredFriends = widget.friends.where((friend) {
      final name = friend.displayName.toLowerCase();
      final username = friend.username.toLowerCase();
      return name.contains(widget.searchQuery.toLowerCase()) ||
          username.contains(widget.searchQuery.toLowerCase());
    }).toList();

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
        itemCount: filteredFriends.length,
        itemBuilder: (context, index) {
          final friend = filteredFriends[index];
          return FriendItem(
            friend: filteredFriends[index],
            onUnfollow: () async {
              friend.isFollowing=!friend.isFollowing;
              bool res=false;
              if(friend.isFollowing){
                await widget.repository.follow(Follow(userId: friend.id));
              }
              else {
                await widget.repository.unfollow(Unfollow(userId: friend.id));
              }

              if(!res){
                friend.isFollowing=!friend.isFollowing;
              }
            },
          );
        },
      )
    );
  }
}