import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/services/time_formating_service.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/locations/presentation/widgets/post_location_save_section.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/location_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';

/// Displays a compact view of a location-based post with image and details.
class LocationPostWidget extends StatefulWidget {
  final LocationPostResponse post;
  final TimeFormatingService timeFormatingService;
  final PostsRepository postsRepository;
  final LocationsRepository locationsRepository;

  /// Creates a [LocationPostWidget] with required dependencies and post data.
  const LocationPostWidget({
    super.key,
    required this.post,
    required this.timeFormatingService,
    required this.postsRepository,
    required this.locationsRepository,
  });

  @override
  State<LocationPostWidget> createState() => _LocationPostWidgetState();
}

/// Manages the state for displaying a location post.
class _LocationPostWidgetState extends State<LocationPostWidget> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  /// Initializes state for the widget.
  @override
  void initState() {
    super.initState();
  }

  /// Retrieves the appropriate image provider based on post locality.
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

  /// Builds the UI with a post image, details, and save option.
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
                GoRouter.of(context).push("$fullPostScreenRoute/${widget.post.id}");
              },
              child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: getImage(widget.post.smallFirstImage),
                fit: BoxFit.cover,
              ),
            ),
            )
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
                    //GPT
                    Text(DateFormat('E, MMM d · h:mm a').format(widget.post.eventTime), style: Theme.of(context).textTheme.labelSmall),
                    Text(widget.post.ownerDisplayName, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(widget.post.description, style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 5),
                    Text("${double.parse((widget.post.point.latitude).toStringAsFixed(7))} ${double.parse((widget.post.point.longitude).toStringAsFixed(7))}", style: Theme.of(context).textTheme.labelSmall),
                  ],
                )),
                PostLocationSaveSection(
                  locationPost: widget.post,
                  locationsRepository: widget.locationsRepository,
                  repository: widget.postsRepository,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
