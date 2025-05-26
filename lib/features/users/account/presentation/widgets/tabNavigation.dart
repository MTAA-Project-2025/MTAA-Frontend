import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';

/// Widget for navigating between account-related tabs (Posts, SavedPosts, LikedPosts).
class TabNavigation extends StatelessWidget {
  final AccountTabType activeTab;
  final Function(AccountTabType) onTabChange;

  /// Creates a [TabNavigation] with the active tab and a callback for tab changes.
  const TabNavigation({
    Key? key,
    required this.activeTab,
    required this.onTabChange,
  }) : super(key: key);

  /// Builds the UI with a row of tab icons and indicators.
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

  /// Builds a single tab with an icon and active state indicator.
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

/// Enum representing the types of account tabs.
enum AccountTabType {
  Posts,
  SavedPosts,
  LikedPosts,
}
