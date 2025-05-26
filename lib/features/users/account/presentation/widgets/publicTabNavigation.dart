import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';

/// Widget for displaying a public profile tab navigation indicator.
class PublicTabNavigation extends StatelessWidget {
  /// Creates a [PublicTabNavigation] widget.
  const PublicTabNavigation({Key? key}) : super(key: key);

  /// Builds the UI with an icon and an active tab indicator.
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
