import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';

class FollowerItem extends StatelessWidget {
  final PublicBaseAccountResponse follower;
  final VoidCallback? onMoreClick;

  const FollowerItem({
    Key? key,
    required this.follower,
    this.onMoreClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: follower.avatar?.images.first.fullPath != null
                    ? CachedNetworkImage(
                        imageUrl: follower.avatar!.images.first.fullPath,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[300],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[300],
                          child: const Icon(Icons.error),
                        ),
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: const Icon(Icons.person),
                      ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    follower.displayName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF263238),
                    ),
                  ),
                  Text(
                    follower.username,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF99A5AC),
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: onMoreClick,
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
