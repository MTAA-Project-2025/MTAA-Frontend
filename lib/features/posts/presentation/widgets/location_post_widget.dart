import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mtaa_frontend/core/services/time_formating_service.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/location_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';

class LocationPostWidget extends StatefulWidget {
  final LocationPostResponse post;
  final TimeFormatingService timeFormatingService;
  final PostsRepository postsRepository;
  final LocationsRepository locationsRepository;

  const LocationPostWidget({super.key, required this.post, required this.timeFormatingService, required this.postsRepository, required this.locationsRepository});

  @override
  State<LocationPostWidget> createState() => _LocationPostWidgetState();
}

class _LocationPostWidgetState extends State<LocationPostWidget> {
  @override
  void initState() {
    super.initState();
  }

  ImageProvider<Object> getImage(MyImageResponse img) {
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: getImage(widget.post.smallFirstImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                    Text(DateFormat('E, MMM d · h:mm a').format(widget.post.eventTime), style: Theme.of(context).textTheme.labelSmall),
                    Text(widget.post.ownerDisplayName, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(widget.post.description, style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 5),
                    Text("${widget.post.point.latitude} ${widget.post.point.longitude}", style: Theme.of(context).textTheme.labelSmall),
                  ],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 24,
                    ),
                    Icon(Icons.bookmark_add_outlined, size: 24),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

enum PostMenuElements { delete, edit, share }
