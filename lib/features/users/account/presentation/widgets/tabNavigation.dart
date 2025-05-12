import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';

class TabNavigation extends StatelessWidget {
  final AccountTabType activeTab;
  final Function(AccountTabType) onTabChange;

  const TabNavigation({
    Key? key,
    required this.activeTab,
    required this.onTabChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTab(AccountTabType.Posts, context),
          _buildTab(AccountTabType.SavedPosts, context),
          _buildTab(AccountTabType.LikedPosts, context),
        ],
      ),
    );
  }

  Widget _buildTab(AccountTabType tabId, BuildContext context) {
    return GestureDetector(
      onTap: () => onTabChange(tabId),
      child: Column(
        children: [
          Container(
            width: 24,
            height: 24,
            child: Icon(
              tabId == AccountTabType.Posts
                ? Icons.photo_library 
                : tabId == AccountTabType.SavedPosts 
                  ? Icons.bookmark 
                  : Icons.favorite,
              color: activeTab == tabId ? secondary1InvincibleColor : Theme.of(context).textTheme.bodyMedium!.color,
              size: 24,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: 38,
            height: 3,
            decoration: BoxDecoration(
              color: activeTab == tabId ? secondary1InvincibleColor : Theme.of(context).textTheme.bodyMedium!.color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }
}

enum AccountTabType{
  Posts,
  SavedPosts,
  LikedPosts,
}