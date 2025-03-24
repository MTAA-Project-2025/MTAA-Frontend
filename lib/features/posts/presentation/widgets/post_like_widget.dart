import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtaa_frontend/core/services/number_formating_service.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:uuid/uuid.dart';

class PostLikeWidget extends StatefulWidget {
  final PostsRepository repository;
  final NumberFormatingService numberFormatingService;
  final int initialLikesCount;
  final bool initialIsLiked;
  final UuidValue postId;

  const PostLikeWidget({super.key, required this.repository, required this.numberFormatingService, required this.initialLikesCount, required this.initialIsLiked, required this.postId});

  @override
  State<PostLikeWidget> createState() => _PostLikeWidgetState();
}

class _PostLikeWidgetState extends State<PostLikeWidget> {
  bool isLiked = false;
  int likesCount = 0;

  @override
  void initState() {
    super.initState();
    isLiked = widget.initialIsLiked;
    likesCount = widget.initialLikesCount;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: isLiked
              ? SvgPicture.asset('assets/icons/heart_active.svg', width: 24, height: 24)
              : SvgPicture.asset('assets/icons/heart.svg', width: 24, height: 24, color: Theme.of(context).textTheme.bodySmall!.color),
          onPressed: () async {
            setState(() {
              isLiked = !isLiked;
              if (isLiked) {
                likesCount++;
              } else {
                likesCount--;
              }
            });

            var res = await widget.repository.likePost(widget.postId);
            setState(() {
              if (!res) {
                isLiked = !isLiked;
                if (isLiked) {
                  likesCount++;
                } else {
                  likesCount--;
                }
              }
            });
          },
        ),
        Text(widget.numberFormatingService.formatNumber(likesCount), style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
