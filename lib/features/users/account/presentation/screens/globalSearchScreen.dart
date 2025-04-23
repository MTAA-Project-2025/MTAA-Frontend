import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/screens/posts_global_search_screen.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/usersGlobalSearch.dart';

class GlobalSearchScreen extends StatefulWidget {
  final PostsRepository postsRepository;
  final AccountRepository usersRepository;

  const GlobalSearchScreen({
    super.key,
    required this.postsRepository,
    required this.usersRepository,
  });

  @override
  State<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> {
  String activeTab = 'posts';
  String searchQuery = '';
  final searchController = TextEditingController();

  @override
  void initState() {
    if (getIt.isRegistered<BuildContext>()) {
      getIt.unregister<BuildContext>();
    }
    getIt.registerSingleton<BuildContext>(context);
    super.initState();
  }

  void onTabChange(String tabId) {
    setState(() {
      activeTab = tabId;
    });
  }

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
            )
          ],
        ),
      ),
    );
  }

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
                  )
                : UsersGlobalSearch(
                    repository: widget.usersRepository,
                  ),
          ),
        ],
      ),
      bottomNavigationBar: PhoneBottomMenu(sellectedType: MenuButtons.Home),
    );
  }
}