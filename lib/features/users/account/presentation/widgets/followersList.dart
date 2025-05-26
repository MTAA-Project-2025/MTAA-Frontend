import 'package:flutter/material.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/followerItem.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';

/// Widget displaying a list of followers with filtering by search query.
class FollowersList extends StatefulWidget {
  final List<PublicBaseAccountResponse> followers;
  final String searchQuery;
  final AccountRepository repository;
  final TokenStorage tokenStorage;

  /// Creates a [FollowersList] with required followers data and dependencies.
  const FollowersList({
    super.key,
    required this.followers,
    this.searchQuery = "",
    required this.repository,
    required this.tokenStorage,
  });

  @override
  State<FollowersList> createState() => _FollowersListState();
}

/// Manages the state for displaying filtered followers.
class _FollowersListState extends State<FollowersList> {
  /// Returns a filtered list of followers based on the search query.
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

  /// Builds the UI with a scrollable list of follower items.
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
            tokenStorage: widget.tokenStorage,
          );
        },
      ),
    );
  }
}
