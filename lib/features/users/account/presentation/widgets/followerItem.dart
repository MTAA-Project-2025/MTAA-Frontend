import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';

class FollowerItem extends StatefulWidget {
  final PublicBaseAccountResponse follower;
  final VoidCallback? onFollowToggle;

  const FollowerItem({
    super.key,
    required this.follower,
    this.onFollowToggle,
  });
  
  @override
  State<FollowerItem> createState() => _FollowerItemState();
}

class _FollowerItemState extends State<FollowerItem> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              GoRouter.of(context).push(
                publicAccountInformationScreenRoute,
                extra: widget.follower.id,
              );
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
                      style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
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
          PopupMenuButton<FollowerMenuAction>(
            icon: Icon(Icons.more_vert, color: theme.iconTheme.color),
            onSelected: (action) {
              if (widget.onFollowToggle != null) {
                widget.onFollowToggle!();
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
