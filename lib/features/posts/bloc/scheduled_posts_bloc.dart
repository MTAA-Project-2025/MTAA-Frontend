import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/core/constants/images/image_size_type.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/posts/bloc/scheduled_posts_event.dart';
import 'package:mtaa_frontend/features/posts/bloc/scheduled_posts_state.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/schedule_post_response.dart';
import 'package:uuid/uuid.dart';

class ScheduledPostsBloc extends Bloc<ScheduledPostsEvent, ScheduledPostsState> {
  ScheduledPostsBloc() : super(ScheduledPostsState(notSyncedPostsHive: [], notSyncedPosts: [])) {
    on<ClearScheduledPostsHiveEvent>((event, emit) {
      emit(ScheduledPostsState(notSyncedPostsHive: [], notSyncedPosts: []));
    });
    on<AddScheduledPostHiveEvent>((event, emit) {
      state.notSyncedPostsHive.add(event.post);
      
      var resp = SchedulePostResponse(
        id: UuidValue.fromString(event.post.id!.uuid),
        description: event.post.description,
        smallFirstImage:MyImageResponse(id: '',
          shortPath: '',
          fullPath: '',
          fileType: '',
          height: 0,
          width: 0,
          aspectRatio: 0,
          type: ImageSizeType.small),
        dataCreationTime: DateTime.now(),
        isHidden: true,
        hiddenReason: '',
        schedulePublishDate: event.post.scheduledDate,
        version: -1,
        isLocal: true
      );
      resp.imageFile=event.post.images.first.image;

      state.notSyncedPosts.add(resp);
      emit(ScheduledPostsState(notSyncedPostsHive: state.notSyncedPostsHive, notSyncedPosts: state.notSyncedPosts));
    });
    on<RemoveScheduledPostHiveEvent>((event, emit) {
      state.notSyncedPostsHive.removeWhere((e) => e.id!.uuid == event.post.id!.uuid);
      state.notSyncedPosts.removeWhere((e) => e.id.uuid == event.post.id!.uuid);
      emit(ScheduledPostsState(notSyncedPostsHive: state.notSyncedPostsHive, notSyncedPosts: state.notSyncedPosts));
    });
  }
}