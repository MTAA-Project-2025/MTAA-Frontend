import 'package:mtaa_frontend/features/posts/data/models/requests/add_post_request.dart';

abstract class ScheduledPostsEvent {}

class ClearScheduledPostsHiveEvent extends ScheduledPostsEvent {}

class AddScheduledPostHiveEvent extends ScheduledPostsEvent {
  final AddPostRequest post;

  AddScheduledPostHiveEvent({required this.post});
}

class RemoveScheduledPostHiveEvent extends ScheduledPostsEvent {
  final AddPostRequest post;

  RemoveScheduledPostHiveEvent({required this.post});
}