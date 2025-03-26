import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtaa_frontend/core/services/number_formating_service.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';

class PostLikeWidget extends StatefulWidget {
  final PostsRepository repository;
  final NumberFormatingService numberFormatingService;
  final FullPostResponse post;

  const PostLikeWidget({super.key, required this.repository, required this.numberFormatingService, required this.post});

  @override
  State<PostLikeWidget> createState() => _PostLikeWidgetState();
}

class _PostLikeWidgetState extends State<PostLikeWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: widget.post.isLiked
              ? SvgPicture.asset('assets/icons/heart_active.svg', width: 24, height: 24)
              : SvgPicture.asset('assets/icons/heart.svg', width: 24, height: 24, color: Theme.of(context).textTheme.bodySmall!.color),
          onPressed: () async {
            setState(() {
              widget.post.isLiked = !widget.post.isLiked;
              if (widget.post.isLiked) {
                widget.post.likesCount++;
              } else {
                widget.post.likesCount--;
              }
            });

            var res = await widget.repository.likePost(widget.post.id);
            setState(() {
              if (!res) {
                widget.post.isLiked = !widget.post.isLiked;
                if (widget.post.isLiked) {
                  widget.post.likesCount++;
                } else {
                  widget.post.likesCount--;
                }
              }
            });
          },
        ),
        Text(widget.numberFormatingService.formatNumber(widget.post.likesCount), style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
