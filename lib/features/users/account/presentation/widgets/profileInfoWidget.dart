import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';

class ProfileInfoWidget extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String username;
  final int friends;
  final int followers;
  final int likes;

  const ProfileInfoWidget({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.username,
    required this.friends,
    required this.followers,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final ImageProvider<Object> avatarImage = avatarUrl.startsWith('http')
        ? NetworkImage(avatarUrl)
        : AssetImage(avatarUrl) as ImageProvider;

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
            name,
            style: textTheme.headlineMedium,
          ),

          // Username
          Text(
            username,
            style: textTheme.labelMedium!.copyWith(fontSize: 13),
          ),
          const SizedBox(height: 10),

          // Stats
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatItem(
                  context,
                  friends.toString(),
                  'Friends',
                  () => context.push(friendsScreenRoute),
                ),
                const SizedBox(width: 10),
                _buildStatItem(
                  context,
                  followers.toString(),
                  'Followers',
                  () => context.push(followersScreenRoute),
                ),
                const SizedBox(width: 10),
                _buildStatItem(
                  context,
                  likes.toString(),
                  'Likes',
                  null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                context,
                'Change Profile',
                () => GoRouter.of(context).push(updateUserScreenRoute),
              ),
              const SizedBox(width: 10),
              _buildButton(
                context,
                'Notifications',
                () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label, VoidCallback? onTap) {
  final textTheme = Theme.of(context).textTheme;

  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Text(value, style: textTheme.headlineMedium!.copyWith(fontSize: 16)),
        Text(label, style: textTheme.labelMedium!.copyWith(fontSize: 13)),
      ],
    ),
  );
}


  Widget _buildButton(BuildContext context, String text, VoidCallback onPressed) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 140,
        decoration: BoxDecoration(
          color: Theme.of(context).textTheme.titleMedium?.color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            text,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              height: 1.2,
              letterSpacing: -0.3,
            ),
          ),
        ),
      ),
    );
  }
}
