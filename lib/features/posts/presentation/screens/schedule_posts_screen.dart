import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/schedule_post_list.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';

class SchedulePostsScreen extends StatefulWidget {
  final PostsRepository repository;

  const SchedulePostsScreen({super.key, required this.repository});

  @override
  State<SchedulePostsScreen> createState() => _SchedulePostsScreenState();
}

class _SchedulePostsScreenState extends State<SchedulePostsScreen> {
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
