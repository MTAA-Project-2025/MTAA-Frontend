import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/core/constants/validators.dart';
import 'package:mtaa_frontend/core/services/number_formating_service.dart';
import 'package:mtaa_frontend/core/services/time_formating_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/comments/bloc/comments_bloc.dart';
import 'package:mtaa_frontend/features/comments/bloc/comments_event.dart';
import 'package:mtaa_frontend/features/comments/bloc/comments_state.dart';
import 'package:mtaa_frontend/features/comments/data/controllers/comment_controller.dart';
import 'package:mtaa_frontend/features/comments/data/models/requests/add_comment_request.dart';
import 'package:mtaa_frontend/features/comments/data/models/responses/full_comment_response.dart';
import 'package:mtaa_frontend/features/comments/data/repositories/comments_repository.dart';
import 'package:mtaa_frontend/features/comments/presentation/widgets/comment_card.dart';
import 'package:mtaa_frontend/features/comments/presentation/widgets/comments_child_list.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_state.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/airmode_error_notification_section.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/commentsTextInput.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/empty_data_notification_section.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/server_error_notification_section.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';
import 'package:uuid/uuid.dart';

class CommentsMainList extends StatefulWidget {
  final UuidValue postId;
  final CommentsRepository commentsRepository;
  final String postOwnerId;
  final TokenStorage tokenStorage;

  const CommentsMainList({super.key, required this.postId, required this.commentsRepository, required this.postOwnerId, required this.tokenStorage});

  @override
  State<CommentsMainList> createState() => _CommentsMainListState();
}

class _CommentsMainListState extends State<CommentsMainList> {
  PageParameters pageParameters = PageParameters(pageNumber: 0, pageSize: 10);
  bool isLoading = false;
  bool isNewLoading = false;
  bool isLoadMoreAvailable = true;
  final TextEditingController createCommentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    loadFirst();
  }

  Future loadFirst() async {
    isLoadMoreAvailable=true;
    if (context.mounted) {
      context.read<CommentsBloc>().add(ClearCommentsEvent());
      pageParameters.pageNumber = 0;
    }
    await loadComments();
  }

  Future loadComments() async {
    if (isLoading) return;
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    var comments = await widget.commentsRepository.getPostComments(widget.postId, pageParameters);
    if(comments.length<pageParameters.pageSize) {
      if(!mounted) return;
      setState(() {
        isLoadMoreAvailable = false;
      });
    }
    if (!mounted) return;
    if (context.mounted) {
      context.read<CommentsBloc>().add(AddMultipleCommentsEvent(comments: comments));
    }
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
    pageParameters.pageNumber++;
  }

  FullCommentResponse? mainComment=null;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExceptionsBloc, ExceptionsState>(builder: (context, state) {
          return BlocBuilder<CommentsBloc, CommentsState>(builder: (context, commentsState) {
            return Column(children: [
              CommentsTextInput(
                  key: const Key('mainCommentInput'),
                  placeholder: 'Write a comment',
                  controller: createCommentTextController,
                  validator: commentValidator,
                  maxLines: 5,
                  isEnabled: false,
                  onCancel: () {
                    createCommentTextController.clear();
                  },
                  isLoading: isNewLoading,
                  onSend: () async {
                    if(!mounted)return;
                    setState(() {
                      isNewLoading = true;
                    });
                    if (createCommentTextController.text.isEmpty) return;
                    var commentId = await widget.commentsRepository.addComment(AddCommentRequest(postId: widget.postId, text: createCommentTextController.text));
                    if (commentId == null) return;
                    var comment = await widget.commentsRepository.getCommentById(commentId);
                    if (comment == null || !mounted || !context.mounted) return;
                    context.read<CommentsBloc>().add(AddFirstCommentEvent(comment: comment));
                    createCommentTextController.clear();
                    if(!mounted)return;
                    setState(() {
                      isNewLoading = false;
                    });
                  }),
              ListView.builder(
                shrinkWrap: true,
                cacheExtent: 9999,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: commentsState.comments.length + 1,
                itemBuilder: (context, index) {
                  if (index < commentsState.comments.length) {
                    final comment = commentsState.comments[index];
                    final commentId = comment.id;
                    final isMovedToTop = comment.isMovedToTop;

                    if(isMovedToTop) {
                      if(mainComment==null){
                        mainComment=commentsState.comments[index-1];
                      }

                      return CommentsChildList(
                        key: ValueKey(commentId),
                        postId: widget.postId,
                        commentsRepository: widget.commentsRepository,
                        postOwnerId: widget.postOwnerId,
                        parentCommentId: commentId,
                        mainParent: mainComment,
                        depth: 1,
                        commentController: CommentController(),
                        isMovedToTop: true,
                        tokenStorage: widget.tokenStorage,);
                    }
                    mainComment=null;
                    return CommentCardWidget(
                      numberFormatingService: getIt<NumberFormatingService>(),
                      comment: commentsState.comments[index],
                      commentsRepository: widget.commentsRepository,
                      timeFormatingService: getIt<TimeFormatingService>(),
                      postId: widget.postId,
                      postOwnerId: widget.postOwnerId,
                      parentCommentId: null,
                      mainParent: commentsState.comments[index],
                      depth: 1,
                      tokenStorage: widget.tokenStorage,
                    );
                  }
                  if (isLoading) {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        DotLoader(),
                      ],
                    );
                  }
                  if (state.isException && state.exceptionType == ExceptionTypes.flightMode) {
                    return AirModeErrorNotificationSectionWidget(
                      onPressed: () {
                        loadFirst();
                      },
                    );
                  }
                  if (state.isException && state.exceptionType == ExceptionTypes.serverError) {
                    return ServerErrorNotificationSectionWidget(
                      onPressed: () {
                        loadFirst();
                      },
                    );
                  }
                  if (commentsState.comments.isEmpty) {
                    return EmptyErrorNotificationSectionWidget(
                      onPressed: null,
                      title: 'No comments found',
                    );
                  }
                  if(isLoadMoreAvailable){
                    return Center(
                      child: TextButton(onPressed: (){
                        loadComments();
                      },
                      style: TextButton.styleFrom(
                        minimumSize: const Size(0, 0),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                      child: const Text('Load more'),),
                    );
                  }
                  return null;
                },
              ),
            ]);
          });
        });
  }
}

enum CommentMenuElement { delete, edit }
