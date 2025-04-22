import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicFullAccountResponse.dart';

class PublicProfileInfoWidget extends StatelessWidget {
  final PublicFullAccountResponse user;
  final VoidCallback onFollowToggle;

  const PublicProfileInfoWidget({
    super.key,
    required this.user,
    required this.onFollowToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final avatarImage = NetworkImage(user.avatar!.images.first.fullPath);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: avatarImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Name
          Text(
            user.displayName,
            style: textTheme.headlineMedium,
          ),

          // Username
          Text(
            '@${user.username}',
            style: textTheme.labelMedium!.copyWith(fontSize: 13),
          ),
          const SizedBox(height: 10),

          // Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatItem(context, '${user.friendsCount}', 'Friends'),
              const SizedBox(width: 10),
              _buildStatItem(context, '${user.followersCount}', 'Followers'),
            ],
          ),
          const SizedBox(height: 10),

          GestureDetector(
            onTap: onFollowToggle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  user.isFollowing ? Icons.favorite : Icons.favorite_border,
                  color: user.isFollowing ? Colors.red : primarily0InvincibleColor,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  user.isFollowing ? "Following" : "Follow",
                  style: const TextStyle(
                    color: primarily0InvincibleColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          value,
          style: textTheme.headlineMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: lightPrimarily2Color,
          ),
        ),
        Text(
          label,
          style: textTheme.labelMedium?.copyWith(
            fontSize: 13,
            color: primarily0InvincibleColor,
          ),
        ),
      ],
    );
  }
}
