import 'package:flutter/material.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/followerItem.dart';

class FollowersList extends StatefulWidget {
  final List<PublicBaseAccountResponse> followers;
  final String searchQuery;
  final AccountRepository repository; 

  const FollowersList({
    super.key,
    required this.followers,
    this.searchQuery = "",
    required this.repository,
  });

  @override
  State<FollowersList> createState() => _FollowersListState();
}

class _FollowersListState extends State<FollowersList> {
  List<PublicBaseAccountResponse> get filteredFollowers {
    if (widget.searchQuery.trim().isEmpty) {
      return widget.followers;
    }
    
    return widget.followers.where((follower) {
      final query = widget.searchQuery.toLowerCase();
      return follower.displayName.toLowerCase().contains(query) ||
          follower.username.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
        itemCount: filteredFollowers.length,
        itemBuilder: (context, index) {
          final follower = filteredFollowers[index];
          return FollowerItem(
            follower: follower,
            repository: widget.repository,
          );
        },
      )
    );
  }
}
