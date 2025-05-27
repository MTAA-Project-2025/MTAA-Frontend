import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/screens/posts_global_search_screen.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/usersGlobalSearch.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';

/// Screen for global search with tabs for posts and users.
class GlobalSearchScreen extends StatefulWidget {
  final PostsRepository postsRepository;
  final AccountRepository usersRepository;
  final TokenStorage tokenStorage;

  /// Creates a [GlobalSearchScreen] with required repositories and token storage.
  const GlobalSearchScreen({
    super.key,
    required this.postsRepository,
    required this.usersRepository,
    required this.tokenStorage,
  });

  @override
  State<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

/// Manages the state for tab navigation in global search.
class _GlobalSearchScreenState extends State<GlobalSearchScreen> {
  String activeTab = 'posts';
  String searchQuery = '';
  final searchController = TextEditingController();

  /// Updates the active tab when changed.
  void onTabChange(String tabId) {
    setState(() {
      activeTab = tabId;
    });
  }

  /// Builds a tab widget with label and active state indicator.
  Widget _buildTab(String tabId, String label) {
    final isActive = activeTab == tabId;
    return GestureDetector(
      onTap: () => onTabChange(tabId),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive ? secondary1InvincibleColor : Theme.of(context).textTheme.bodyMedium!.color,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 3,
              width: 40,
              decoration: BoxDecoration(
                color: isActive ? secondary1InvincibleColor : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the UI with tab navigation and search content.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTab('posts', 'Posts'),
              _buildTab('users', 'Users'),
            ],
          ),
          Expanded(
            child: activeTab == 'posts'
                ? PostsGlobalSearchScreen(
                    repository: widget.postsRepository,
                    tokenStorage: widget.tokenStorage,
                  )
                : UsersGlobalSearch(
                    repository: widget.usersRepository,
                    tokenStorage: widget.tokenStorage,
                  ),
          ),
        ],
      ),
      bottomNavigationBar: PhoneBottomMenu(sellectedType: MenuButtons.Home),
    );
  }
}
