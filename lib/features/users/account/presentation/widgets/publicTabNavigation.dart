import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';

class PublicTabNavigation extends StatelessWidget {
  const PublicTabNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
      child: Column(
        children: [
          Icon(
            Icons.photo_library,
            color: secondary1InvincibleColor,
            size: 24,
          ),
          const SizedBox(height: 5),
          Container(
            width: 38,
            height: 3,
            decoration: BoxDecoration(
              color: secondary1InvincibleColor,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }
}
