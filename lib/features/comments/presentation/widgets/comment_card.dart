import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/images/image_size_type.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/constants/validators.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/core/services/number_formating_service.dart';
import 'package:mtaa_frontend/core/services/time_formating_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/comments/bloc/comments_bloc.dart';
import 'package:mtaa_frontend/features/comments/bloc/comments_event.dart';
import 'package:mtaa_frontend/features/comments/data/controllers/comment_controller.dart';
import 'package:mtaa_frontend/features/comments/data/models/requests/add_comment_request.dart';
import 'package:mtaa_frontend/features/comments/data/models/requests/update_comment_request.dart';
import 'package:mtaa_frontend/features/comments/data/models/responses/comment_interaction_type.dart';
import 'package:mtaa_frontend/features/comments/data/models/responses/full_comment_response.dart';
import 'package:mtaa_frontend/features/comments/data/repositories/comments_repository.dart';
import 'package:mtaa_frontend/features/comments/presentation/widgets/comments_child_list.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/commentsTextInput.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';
import 'package:uuid/uuid.dart';

/// Displays a comment with interaction options and nested replies.
class CommentCardWidget extends StatefulWidget {
  final NumberFormatingService numberFormatingService;
  final TimeFormatingService timeFormatingService;
  final FullCommentResponse comment;
  final CommentsRepository commentsRepository;
  final UuidValue postId;
  final String postOwnerId;
  final UuidValue? parentCommentId;
  final FullCommentResponse? mainParent;
  final CommentController? parentCommentController;
  final double depth;
  final TokenStorage tokenStorage;

  /// Creates a [CommentCardWidget] with required dependencies and configuration.
  const CommentCardWidget(
      {super.key,
      required this.numberFormatingService,
      required this.comment,
      required this.commentsRepository,
      required this.timeFormatingService,
      required this.postId,
      required this.postOwnerId,
      required this.parentCommentId,
      required this.mainParent,
      required this.depth,
      this.parentCommentController,
      required this.tokenStorage});

  @override
  State<CommentCardWidget> createState() => _CommentCardWidgetState();
}

/// Manages the state and interactions of a comment card.
class _CommentCardWidgetState extends State<CommentCardWidget> {
  int commentsCount = 0;
  bool isTextOpen = false;
  bool isReplySectionActive = false;
  bool isEditSectionActive = false;
  bool isChildrenOpen = false;
  final TextEditingController createCommentTextController = TextEditingController();
  final TextEditingController editCommentTextController = TextEditingController();
  late String userId;
  final CommentController commentController = CommentController();
  bool isEditLoading = false;
  bool isChildLoading = false;

  /// Initializes state and sets up parent comment controller and user ID.
  @override
  void initState() {
    super.initState();

    if (widget.parentCommentController != null) {
      widget.parentCommentController!.closeChildComments = () {
        if (!mounted) return;
        if (isChildrenOpen) {
          commentController.closeChildren();

          if (!mounted) return;
          isChildrenOpen = false;
          if (widget.depth % 5 == 0) {
            if (context.mounted) {
              context.read<CommentsBloc>().add(RemoveNextCommentsEvent(comment: widget.comment));
            }
          }
        }
      };
    }

    Future.microtask(() async {
      var uId = await widget.tokenStorage.getUserId();
      if (!mounted) return;
      if (uId != null) {
        userId = uId;
      }
    });
  }

  /// Returns the appropriate image provider for a user's avatar.
  ImageProvider<Object> getImage(MyImageResponse img) {
    if (!img.localPath.isNotEmpty) {
      return NetworkImage(img.fullPath);
    }
    File file = File(img.localPath);

    if (file.existsSync()) {
      return FileImage(file);
    }
    return AssetImage('assets/images/kistune_server_error.png');
  }

  /// Builds the comment card UI with interactions and reply functionality.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                if (userId == widget.comment.owner.id) {
                  GoRouter.of(context).push(accountProfileScreenRoute);
                } else {
                  GoRouter.of(context).push(publicAccountInformationScreenRoute, extra: widget.comment.owner.id);
                }
              },
              child: Row(
                children: [
                  if (widget.comment.owner.avatar != null)
                    ClipOval(
                      child: Image(
                        image: getImage(widget.comment.owner.avatar!.images.firstWhere((element) => element.type == ImageSizeType.small)),
                        width: 31,
                        height: 31,
                      ),
                    ),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.comment.owner.displayName,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.timeFormatingService.formatTimeAgo(widget.comment.dataCreationTime),
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      if (widget.comment.type == CommentInteractionType.Like) {
                        if (!mounted) return;
                        setState(() {
                          widget.comment.type = CommentInteractionType.None;
                          widget.comment.likesCount--;
                        });
                        bool res = await widget.commentsRepository.setInteractionToNone(widget.comment.id);
                        if (!res) {
                          if (!mounted) return;
                          setState(() {
                            widget.comment.type = CommentInteractionType.Like;
                            widget.comment.likesCount++;
                          });
                        }
                      } else if (widget.comment.type == CommentInteractionType.Dislike) {
                        if (!mounted) return;
                        setState(() {
                          widget.comment.type = CommentInteractionType.Like;
                          widget.comment.likesCount++;
                          widget.comment.dislikesCount--;
                        });
                        bool res = await widget.commentsRepository.likeComment(widget.comment.id);
                        if (!res) {
                          if (!mounted) return;
                          setState(() {
                            widget.comment.type = CommentInteractionType.Dislike;
                            widget.comment.likesCount--;
                            widget.comment.dislikesCount++;
                          });
                        }
                      } else {
                        if (!mounted) return;
                        setState(() {
                          widget.comment.type = CommentInteractionType.Like;
                          widget.comment.likesCount++;
                        });
                        bool res = await widget.commentsRepository.likeComment(widget.comment.id);
                        if (!res) {
                          if (!mounted) return;
                          setState(() {
                            widget.comment.type = CommentInteractionType.None;
                            widget.comment.likesCount--;
                          });
                        }
                      }
                    },
                    icon: Icon(Icons.arrow_upward_outlined,
                        color: widget.comment.type == CommentInteractionType.Like ? Theme.of(context).textTheme.labelSmall!.color : Theme.of(context).textTheme.bodyMedium!.color)),
                Text(widget.numberFormatingService.formatNumber(widget.comment.likesCount - widget.comment.dislikesCount), style: Theme.of(context).textTheme.labelSmall),
                IconButton(
                    onPressed: () async {
                      if (widget.comment.type == CommentInteractionType.Like) {
                        if (!mounted) return;
                        setState(() {
                          widget.comment.type = CommentInteractionType.Dislike;
                          widget.comment.likesCount--;
                          widget.comment.dislikesCount++;
                        });
                        bool res = await widget.commentsRepository.dislikeComment(widget.comment.id);
                        if (!res) {
                          if (!mounted) return;
                          setState(() {
                            widget.comment.type = CommentInteractionType.Like;
                            widget.comment.likesCount++;
                            widget.comment.dislikesCount--;
                          });
                        }
                      } else if (widget.comment.type == CommentInteractionType.Dislike) {
                        if (!mounted) return;
                        setState(() {
                          widget.comment.type = CommentInteractionType.None;
                          widget.comment.dislikesCount--;
                        });
                        bool res = await widget.commentsRepository.setInteractionToNone(widget.comment.id);
                        if (!res) {
                          if (!mounted) return;
                          setState(() {
                            widget.comment.type = CommentInteractionType.Dislike;
                            widget.comment.dislikesCount++;
                          });
                        }
                      } else {
                        if (!mounted) return;
                        setState(() {
                          widget.comment.type = CommentInteractionType.Dislike;
                          widget.comment.dislikesCount++;
                        });
                        bool res = await widget.commentsRepository.dislikeComment(widget.comment.id);
                        if (!res) {
                          if (!mounted) return;
                          setState(() {
                            widget.comment.type = CommentInteractionType.None;
                            widget.comment.dislikesCount--;
                          });
                        }
                      }
                    },
                    icon: Icon(Icons.arrow_downward_outlined,
                        color: widget.comment.type == CommentInteractionType.Dislike ? Theme.of(context).textTheme.labelSmall!.color : Theme.of(context).textTheme.bodyMedium!.color)),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        isEditSectionActive
            ? CommentsTextInput(
                key: const Key('editCommentTextInput'),
                placeholder: 'Edit comment',
                controller: editCommentTextController,
                validator: commentValidator,
                maxLines: 5,
                isEnabled: true,
                isLoading: isEditLoading,
                onCancel: () {
                  editCommentTextController.clear();
                  setState(() {
                    isEditSectionActive = false;
                  });
                },
                onSend: () async {
                  if (!mounted) return;
                  setState(() {
                    isEditLoading = true;
                  });
                  if (editCommentTextController.text.isEmpty) return;
                  var res = await widget.commentsRepository.updateComment(UpdateCommentRequest(commentId: widget.comment.id, text: editCommentTextController.text));
                  if (!res || !mounted || !context.mounted) return;
                  if (!mounted) return;
                  setState(() {
                    isEditLoading = false;
                    widget.comment.text = editCommentTextController.text;
                    widget.comment.isEdited = true;
                    isEditSectionActive = false;
                  });
                  editCommentTextController.clear();
                })
            : Container(
                width: double.infinity,
                child: Text.rich(
                    textAlign: TextAlign.start,
                    TextSpan(
                      text: (widget.comment.text.length <= 400 || isTextOpen) ? widget.comment.text : '${widget.comment.text.substring(0, 400)}... ',
                      style: Theme.of(context).textTheme.bodySmall,
                      children: [
                        if (widget.comment.text.length > 400)
                          TextSpan(
                            text: isTextOpen ? ' less' : ' more',
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 10),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  isTextOpen = !isTextOpen;
                                });
                              },
                          ),
                      ],
                    )),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  isReplySectionActive = !isReplySectionActive;
                });
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.secondary,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.all(0),
                minimumSize: const Size(0, 0),
                textStyle: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              child: Text(
                'Reply',
              ),
            ),
            PopupMenuButton<CommentMenuElement>(
              initialValue: null,
              onSelected: (CommentMenuElement item) {
                if (item == CommentMenuElement.edit) {
                  if (!mounted) return;
                  editCommentTextController.text = widget.comment.text;
                  setState(() {
                    isEditSectionActive = true;
                  });
                } else if (item == CommentMenuElement.delete) {
                  if (!mounted || !context.mounted) return;
                  context.read<CommentsBloc>().add(RemoveCommentEvent(comment: widget.comment));
                  widget.commentsRepository.deleteComment(widget.comment.id);
                  getIt.get<MyToastService>().showMsgWithContext('Comment is successfully deleted', context);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<CommentMenuElement>>[
                if (userId == widget.comment.owner.id) PopupMenuItem<CommentMenuElement>(value: CommentMenuElement.edit, child: Text('Edit', style: Theme.of(context).textTheme.bodyMedium)),
                if (userId == widget.comment.owner.id || userId == widget.postOwnerId)
                  PopupMenuItem<CommentMenuElement>(value: CommentMenuElement.delete, child: Text('Delete', style: Theme.of(context).textTheme.bodyMedium)),
              ],
            ),
          ],
        ),
        if (widget.comment.childCommentsCount > 0)
          InkWell(
            onTap: () {
              setState(() {
                isChildrenOpen = !isChildrenOpen;
              });
              if (!isChildrenOpen) {
                commentController.closeChildren();
              }
              if (widget.depth % 5 == 0) {
                if (isChildrenOpen) {
                  FullCommentResponse comment = FullCommentResponse(
                    id: widget.comment.id,
                    text: widget.comment.text,
                    owner: widget.comment.owner,
                    dataCreationTime: widget.comment.dataCreationTime,
                    likesCount: widget.comment.likesCount,
                    dislikesCount: widget.comment.dislikesCount,
                    type: widget.comment.type,
                    childCommentsCount: widget.comment.childCommentsCount,
                    parentCommentId: widget.comment.parentCommentId,
                    isEdited: widget.comment.isEdited,
                  );
                  comment.isMovedToTop = true;
                  if (context.mounted) {
                    context.read<CommentsBloc>().add(AddNextCommentEvent(comment: widget.mainParent!, commentToPlace: comment));
                  }
                } else {
                  if (context.mounted) {
                    context.read<CommentsBloc>().add(RemoveNextCommentsEvent(comment: widget.comment));
                  }
                }
              }
            },
            child: Row(
              children: [
                Icon(isChildrenOpen ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
                const SizedBox(width: 5),
                Text(
                  '${widget.comment.childCommentsCount} replies',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
          ),
        Column(children: [
          if (isReplySectionActive)
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CommentsTextInput(
                    placeholder: 'Write a reply',
                    controller: createCommentTextController,
                    validator: commentValidator,
                    maxLines: 5,
                    isEnabled: true,
                    isLoading: isChildLoading,
                    onCancel: () {
                      createCommentTextController.clear();
                      setState(() {
                        isReplySectionActive = false;
                         isChildLoading = false;
                      });
                    },
                    onSend: () async {
                      if (createCommentTextController.text.isEmpty) {
                        getIt.get<MyToastService>().showMsg('Comment cannot be empty');
                        return;
                      }
                      if (!mounted) return;
                      setState(() {
                        isChildLoading = true;
                      });
                      var commentId = await widget.commentsRepository.addComment(AddCommentRequest(postId: widget.postId, text: createCommentTextController.text, parentCommentId: widget.comment.id));
                      if (commentId == null) return;
                      var comment = await widget.commentsRepository.getCommentById(commentId);
                      if (comment == null || !mounted || !context.mounted) return;
                      createCommentTextController.clear();
                      if (!mounted) return;
                      commentController.add(comment);
                      if (!mounted) return;
                      setState(() {
                        isChildLoading = false;
                        isReplySectionActive = false;
                        widget.comment.childCommentsCount++;
                      });
                    })),
          if (isChildrenOpen && widget.depth % 5 != 0)
            CommentsChildList(
                commentsRepository: widget.commentsRepository,
                postId: widget.postId,
                postOwnerId: widget.postOwnerId,
                parentCommentId: widget.comment.id,
                mainParent: widget.mainParent,
                depth: widget.depth,
                commentController: commentController,
                tokenStorage: widget.tokenStorage),
        ])
      ],
    );
  }
}

/// Defines options for the comment menu.
enum CommentMenuElement { delete, edit }
