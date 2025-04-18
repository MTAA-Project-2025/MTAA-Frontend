import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
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
    ImageProvider<Object> avatarImage;
    if (avatarUrl.startsWith('http')) {
      avatarImage = NetworkImage(avatarUrl);
    } else {
      avatarImage = AssetImage(avatarUrl);
    }

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
            style: const TextStyle(
              color: lightPrimarily2Color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1,
              letterSpacing: -0.01,
            ),
          ),
          const SizedBox(height: 10),
          
          // Username
          Text(
            username,
            style: const TextStyle(
              color: primarily0InvincibleColor,
              fontSize: 13,
              height: 1,
              letterSpacing: -0.01,
            ),
          ),
          const SizedBox(height: 10),
          
          // Stats
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatItem(friends.toString(), 'Friends'),
                const SizedBox(width: 10),
                _buildStatItem(followers.toString(), 'Followers'),
                const SizedBox(width: 10),
                _buildStatItem(likes.toString(), 'Likes'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('Change Profile', () {
                GoRouter.of(context).go(updateUserScreenRoute);
              }),
              const SizedBox(width: 10),
              _buildButton('Notifications', () {
                
              }),
            ],
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
            height: 1,
            letterSpacing: -0.01,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: primarily0InvincibleColor,
            fontSize: 13,
            height: 1,
            letterSpacing: -0.01,
          ),
        ),
      ],
    );
  }

Widget _buildButton(String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 23,
        width: 140,
        decoration: BoxDecoration(
          color: secondary1InvincibleColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1.2,
              letterSpacing: -0.3,
            ),
          ),
        ),
      ),
    );
  }
}
