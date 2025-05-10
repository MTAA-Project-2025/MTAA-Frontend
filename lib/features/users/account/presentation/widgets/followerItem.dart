import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/follow.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/unfollow.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';

class FollowerItem extends StatefulWidget {
  final PublicBaseAccountResponse follower;
  final AccountRepository repository;
  final TokenStorage tokenStorage;

  const FollowerItem({
    super.key,
    required this.follower,
    required this.repository,
    required this.tokenStorage,
  });

  @override
  State<FollowerItem> createState() => _FollowerItemState();
}

class _FollowerItemState extends State<FollowerItem> {

  String userId = '';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    Future.microtask(() async {
      if (!mounted) return;
      String? res = await widget.tokenStorage.getUserId();
      if(res== null || !mounted) return;
      setState(() {
        userId = res;
      });
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if(userId== widget.follower.id) {
                GoRouter.of(context).push(accountProfileScreenRoute);
              }
              else {
                GoRouter.of(context).push(
                  publicAccountInformationScreenRoute,
                  extra: widget.follower.id,
                );
              }
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: widget.follower.avatar?.images.first.fullPath != null
                      ? CachedNetworkImage(
                          imageUrl: widget.follower.avatar!.images.first.fullPath,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 70,
                            height: 70,
                            color: theme.secondaryHeaderColor,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 70,
                            height: 70,
                            color: theme.secondaryHeaderColor,
                            child: const Icon(Icons.error),
                          ),
                        )
                      : Container(
                          width: 80,
                          height: 80,
                          color: theme.secondaryHeaderColor,
                          child: Icon(Icons.person, color: colorScheme.primary),
                        ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.follower.displayName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.follower.username,
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if(userId != widget.follower.id && userId != '')
          PopupMenuButton<FollowerMenuAction>(
            icon: Icon(Icons.more_vert, color: theme.iconTheme.color),
            onSelected: (action) async {
              switch (action) {
                case FollowerMenuAction.follow:
                  if (!mounted) return;
                  setState(() {
                    widget.follower.isFollowing = true;
                  });
                  bool res = await widget.repository.follow(Follow(userId: widget.follower.id));

                  if (!res) {
                    if (!mounted) return;
                    setState(() {
                      widget.follower.isFollowing = false;
                    });
                  }
                  break;
                case FollowerMenuAction.unfollow:
                  if (!mounted) return;
                  setState(() {
                    widget.follower.isFollowing = false;
                  });
                  bool res = await widget.repository.unfollow(Unfollow(userId: widget.follower.id));

                  if (!res) {
                    if (!mounted) return;
                    setState(() {
                      widget.follower.isFollowing = true;
                    });
                  }
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FollowerMenuAction>>[
              PopupMenuItem<FollowerMenuAction>(
                value: widget.follower.isFollowing ? FollowerMenuAction.unfollow : FollowerMenuAction.follow,
                child: Text(
                  widget.follower.isFollowing ? 'Unfollow' : 'Follow',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum FollowerMenuAction { follow, unfollow }
