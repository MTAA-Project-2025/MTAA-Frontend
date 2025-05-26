import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/location_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';

/// Displays a section for saving or navigating to a post's location.
class PostLocationSaveSection extends StatefulWidget {
  final PostsRepository repository;
  final LocationsRepository locationsRepository;
  final FullPostResponse? post;
  final LocationPostResponse? locationPost;

  /// Creates a [PostLocationSaveSection] with required dependencies and optional post data.
  const PostLocationSaveSection({
    super.key,
    required this.repository,
    this.post,
    this.locationPost,
    required this.locationsRepository,
  });

  @override
  State<PostLocationSaveSection> createState() => _PostLocationSaveSectionState();
}

/// Manages the state for saving and navigating to a post's location.
class _PostLocationSaveSectionState extends State<PostLocationSaveSection> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  bool isSaved = false;

  /// Initializes state and checks if the post is saved.
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (!mounted) return;
      bool res = false;
      if (widget.locationPost != null) {
        res = await widget.repository.isLocationPostSaved(widget.locationPost!.id);
      } else if (widget.post != null) {
        res = await widget.repository.isLocationPostSaved(widget.post!.id);
      }
      if (!mounted) return;
      setState(() {
        isSaved = res;
      });
    });
  }

  /// Builds the UI with location and save/unsave buttons.
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            visualDensity: VisualDensity.compact,
            style: Theme.of(context).iconButtonTheme.style?.copyWith(
                  iconColor: WidgetStateProperty.all(Theme.of(context).textTheme.bodySmall!.color),
                ),
            icon: Icon(
              Icons.location_on_outlined,
              size: 24,
            ),
            onPressed: () async {
              if (widget.locationPost != null) {
                GoRouter.of(context).push(onePointScreenRoute, extra: widget.locationPost!.point);
                widget.locationPost!.isSaved = !widget.locationPost!.isSaved;
              } else if (widget.post != null) {
                if (widget.post!.locationId != null) {
                  GoRouter.of(context).push('$onePointScreenRoute/${widget.post!.locationId!.uuid}');
                }
              }
            },
          ),
        ),
        SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              visualDensity: VisualDensity.compact,
              style: Theme.of(context).iconButtonTheme.style?.copyWith(
                    iconColor: isSaved ? WidgetStateProperty.all(Theme.of(context).textTheme.titleMedium!.color) : WidgetStateProperty.all(Theme.of(context).textTheme.bodySmall!.color),
                  ),
              icon: Icon(
                isSaved ? Icons.bookmark_remove_outlined : Icons.bookmark_add_outlined,
                size: 24,
              ),
              onPressed: () async {
                if(!mounted)return;
                setState(() {
                  isSaved = !isSaved;
                  if (widget.locationPost != null) {
                    widget.locationPost!.isSaved = !widget.locationPost!.isSaved;
                  } else if (widget.post != null) {
                    widget.post!.isSaved = !widget.post!.isSaved;
                  }
                });

              bool res = false;

                if (isSaved) {
                  analytics.logSelectItem(itemListId: widget.post?.id.toString(), itemListName: 'saved_posts');
                  if (widget.locationPost != null) {
                    await widget.repository.saveLocationPost(widget.locationPost!);
                    res = true;
                  } else if (widget.post != null) {
                    LocationPostResponse? post = await widget.locationsRepository.getLocationPostById(widget.post!.id);

                    if (post != null) {
                      await widget.repository.saveLocationPost(post);
                      res = true;
                    }
                  }
                } else {
                  if (widget.locationPost != null) {
                    await widget.repository.removeLocationPost(widget.locationPost!);
                    res = true;
                  } else if (widget.post != null) {
                    LocationPostResponse? post = await widget.locationsRepository.getLocationPostById(widget.post!.id);

                    if (post != null) {
                      await widget.repository.removeLocationPost(post);
                      res = true;
                    }
                  }
                }
                if (!res) {
                  if (!mounted) return;
                  setState(() {
                    isSaved = !isSaved;
                    if (widget.locationPost != null) {
                      widget.locationPost!.isSaved = !widget.locationPost!.isSaved;
                    } else if (widget.post != null) {
                      widget.post!.isSaved = !widget.post!.isSaved;
                    }
                  });
                }
              },
            )),
      ],
    );
  }
}
