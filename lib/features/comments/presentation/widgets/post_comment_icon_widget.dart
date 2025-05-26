import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtaa_frontend/core/services/number_formating_service.dart';
import 'package:uuid/uuid.dart';

/// Displays a comment icon with the number of comments for a post.
class PostCommentIconWidget extends StatefulWidget {
  final NumberFormatingService numberFormatingService;
  final int initialCommentsCount;
  final UuidValue postId;

  /// Creates a [PostCommentIconWidget] with required dependencies.
  const PostCommentIconWidget({
    super.key,
    required this.numberFormatingService,
    required this.initialCommentsCount,
    required this.postId,
  });

  @override
  State<PostCommentIconWidget> createState() => _PostCommentIconWidgetState();
}

/// Manages the state of the comment icon and count display.
class _PostCommentIconWidgetState extends State<PostCommentIconWidget> {
  int commentsCount = 0;

  /// Initializes the comment count from the widget's initial value.
  @override
  void initState() {
    super.initState();
    commentsCount = widget.initialCommentsCount;
  }

  /// Builds the UI with a comment icon and formatted comment count.
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
