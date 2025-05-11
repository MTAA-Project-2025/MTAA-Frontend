import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/services/time_formating_service.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/schedule_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';

class SchedulePostCardWidget extends StatefulWidget {
  final SchedulePostResponse post;
  final TimeFormatingService timeFormatingService;
  final PostsRepository postsRepository;
  final LocationsRepository locationsRepository;

  const SchedulePostCardWidget({super.key, required this.post, required this.timeFormatingService, required this.postsRepository, required this.locationsRepository});

  @override
  State<SchedulePostCardWidget> createState() => _SchedulePostWidgetState();
}

class _SchedulePostWidgetState extends State<SchedulePostCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  ImageProvider<Object> getImage(MyImageResponse img) {
    if(widget.post.imageFile != null) {
      return FileImage(widget.post.imageFile!);
    }
    if (!widget.post.isLocal) {
      return NetworkImage(img.fullPath);
    }
    File file = File(img.localPath);

    if (file.existsSync()) {
      return FileImage(file);
    }
    return AssetImage('assets/images/kistune_server_error.png');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 116,
              height: 116,
              child: InkWell(
                onTap: () {
                  if(widget.post.version==-1)return;
                  GoRouter.of(context).push("$fullPostScreenRoute/${widget.post.id}");
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                    image: getImage(widget.post.smallFirstImage),
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          const SizedBox(width: 10),
          Expanded(
              child: Container(
            height: 116,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //GPT
                    if (widget.post.schedulePublishDate != null) Text(DateFormat('E, MMM d · h:mm a').format(widget.post.schedulePublishDate!), style: Theme.of(context).textTheme.labelSmall),
                    Text(widget.post.description, style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 5),
                    if (widget.post.schedulePublishDate != null)
                      Row(
                        children: [
                          Icon(
                            Icons.access_alarm,
                          ),
                          Text('Scheduled')
                        ],
                      ),
                    if (widget.post.schedulePublishDate == null && widget.post.version != -1)
                      Row(
                        children: [
                          Icon(
                            Icons.report_problem,
                          ),
                          if (widget.post.hiddenReason != null) Text(widget.post.hiddenReason!),
                          if (widget.post.hiddenReason == null) Text('Problem')
                        ],
                      ),
                    if (widget.post.version == -1)
                      Row(
                        children: [
                          Icon(
                            Icons.sync,
                          ),
                          Text('Post is not synced yet')
                        ],
                      )
                  ],
                )),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
