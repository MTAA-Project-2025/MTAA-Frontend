import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtaa_frontend/core/services/number_formating_service.dart';
import 'package:uuid/uuid.dart';

class PostCommentIconWidget extends StatefulWidget {
  final NumberFormatingService numberFormatingService;
  final int initialCommentsCount;
  final UuidValue postId;

  const PostCommentIconWidget({super.key, required this.numberFormatingService, required this.initialCommentsCount, required this.postId});

  @override
  State<PostCommentIconWidget> createState() => _PostCommentIconWidgetState();
}

class _PostCommentIconWidgetState extends State<PostCommentIconWidget> {
  int commentsCount = 0;

  @override
  void initState() {
    super.initState();
    commentsCount = widget.initialCommentsCount;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 6),
        Padding(padding: EdgeInsets.symmetric(horizontal: 10), child:
        SvgPicture.asset('assets/icons/comments.svg', width: 24, height: 24, color: Theme.of(context).textTheme.bodySmall!.color),
        ),
        

        Text(widget.numberFormatingService.formatNumber(commentsCount), style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
