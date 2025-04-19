import 'package:flutter/material.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/followerItem.dart';

class FollowersList extends StatelessWidget {
  final List<PublicBaseAccountResponse> followers;
  final String searchQuery;

  const FollowersList({
    super.key,
    required this.followers,
    this.searchQuery = "",
  });

  List<PublicBaseAccountResponse> get filteredFollowers {
    if (searchQuery.trim().isEmpty) {
      return followers;
    }
    
    return followers.where((follower) {
      final query = searchQuery.toLowerCase();
      return follower.displayName.toLowerCase().contains(query) ||
          follower.username.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredFollowers.length,
      itemBuilder: (context, index) {
        final follower = filteredFollowers[index];
        return FollowerItem(
          follower: follower,
          onMoreClick: () {
            print('More options clicked for follower with ID: ${follower.id}');
          },
        );
      },
    );
  }
}
