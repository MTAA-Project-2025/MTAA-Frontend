import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/schedule_post_list.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';

/// Displays a screen for viewing scheduled posts.
class SchedulePostsScreen extends StatefulWidget {
  final PostsRepository repository;

  /// Creates a [SchedulePostsScreen] with required dependencies.
  const SchedulePostsScreen({super.key, required this.repository});

  @override
  State<SchedulePostsScreen> createState() => _SchedulePostsScreenState();
}

/// Manages the state for displaying the scheduled posts list.
class _SchedulePostsScreenState extends State<SchedulePostsScreen> {
  /// Builds the UI with a scrollable list of scheduled posts and navigation.
  @override
  Widget build(BuildContext contex) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Scheduled Posts'),
        ),
        body:
          SingleChildScrollView(
            child: SchedulePostList(
              repository: widget.repository,
            ),
          ),
        bottomNavigationBar: PhoneBottomMenu(sellectedType: MenuButtons.Settings));
  }
}
