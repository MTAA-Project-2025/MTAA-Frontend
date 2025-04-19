import 'package:flutter/material.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';

class FriendItem extends StatelessWidget {
  final PublicBaseAccountResponse friend;
  final VoidCallback? onUnfollow;

  const FriendItem({
    super.key,
    required this.friend,
    this.onUnfollow,
  });

  @override
  Widget build(BuildContext context) {
    final avatarUrl = friend.avatar?.images.first.fullPath;

    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: avatarUrl != null
                    ? NetworkImage(avatarUrl)
                    : const AssetImage('assets/images/avatar_placeholder.png') as ImageProvider,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    friend.displayName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF263238),
                    ),
                  ),
                  Text(
                    "@${friend.username}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF99A5AC),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (friend.isFollowing)
            ElevatedButton(
              onPressed: onUnfollow,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7043),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              ),
              child: const Text(
                "unfollow",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}