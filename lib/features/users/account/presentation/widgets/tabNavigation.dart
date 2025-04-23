import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';

class TabNavigation extends StatelessWidget {
  final String activeTab;
  final Function(String) onTabChange;

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
          _buildTab('photos', context),
          _buildTab('bookmarks', context),
          _buildTab('likes', context),
        ],
      ),
    );
  }

  Widget _buildTab(String tabId, BuildContext context) {
    return GestureDetector(
      onTap: () => onTabChange(tabId),
      child: Column(
        children: [
          Container(
            width: 24,
            height: 24,
            child: Icon(
              tabId == 'photos' 
                ? Icons.photo_library 
                : tabId == 'bookmarks' 
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
