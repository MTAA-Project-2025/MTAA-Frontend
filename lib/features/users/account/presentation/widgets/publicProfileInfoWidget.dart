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
            style: const TextStyle(
              color: lightPrimarily2Color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          // Username
          Text(
            '@${user.username}',
            style: const TextStyle(
              color: primarily0InvincibleColor,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),

          // Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatItem('${user.friendsCount}', 'Friends'),
              const SizedBox(width: 10),
              _buildStatItem('${user.followersCount}', 'Followers'),
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

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: lightPrimarily2Color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: primarily0InvincibleColor,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
