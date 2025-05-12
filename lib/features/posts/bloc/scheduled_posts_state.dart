import 'package:mtaa_frontend/features/posts/data/models/requests/add_post_request.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/schedule_post_response.dart';

class ScheduledPostsState {
  final List<AddPostRequest> notSyncedPostsHive;
  final List<SchedulePostResponse> notSyncedPosts;

  ScheduledPostsState({required this.notSyncedPostsHive, required this.notSyncedPosts});
}