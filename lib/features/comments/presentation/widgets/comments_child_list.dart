import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/core/services/number_formating_service.dart';
import 'package:mtaa_frontend/core/services/time_formating_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/comments/data/controllers/comment_controller.dart';
import 'package:mtaa_frontend/features/comments/data/models/responses/full_comment_response.dart';
import 'package:mtaa_frontend/features/comments/data/repositories/comments_repository.dart';
import 'package:mtaa_frontend/features/comments/presentation/widgets/comment_card.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_state.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/server_error_notification_section.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';
import 'package:uuid/uuid.dart';

class CommentsChildList extends StatefulWidget {
  final UuidValue postId;
  final String postOwnerId;
  final CommentsRepository commentsRepository;
  final UuidValue parentCommentId;
  final FullCommentResponse? mainParent;
  final double depth;
  final CommentController commentController;
  final bool isMovedToTop;
  final TokenStorage tokenStorage;

  const CommentsChildList(
      {super.key,
      required this.postId,
      required this.commentsRepository,
      required this.postOwnerId,
      required this.parentCommentId,
      required this.mainParent,
      required this.depth,
      required this.commentController,
      required this.tokenStorage,
      this.isMovedToTop = false});

  @override
  State<CommentsChildList> createState() => _CommentsChildListState();
}

class _CommentsChildListState extends State<CommentsChildList> {
  PageParameters pageParameters = PageParameters(pageNumber: 0, pageSize: 10);
  bool isLoading = false;
  final TextEditingController createCommentTextController = TextEditingController();

  List<FullCommentResponse> childComments = [];
  bool isLoadMoreAvailable = true;

  List<CommentController> childCommentControllers = [];

  @override
  void initState() {
    super.initState();

    widget.commentController.addComment = (FullCommentResponse comment) {
      if (!mounted) return;
      setState(() {
        childComments.insert(0, comment);
        childCommentControllers.insert(0, CommentController());
      });
    };

    widget.commentController.closeChildComments = (){
      if (!mounted) return;
      for (var element in childCommentControllers) {
        element.closeChildren();
      }
    };

    loadFirst();
  }

  Future loadFirst() async {
    if (!context.mounted) return;
    isLoadMoreAvailable = true;
    childComments = [];
    childCommentControllers=[];
    pageParameters.pageNumber = 0;

    await loadComments();
  }

  Future loadComments() async {
    if (isLoading) return;
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    var res = await widget.commentsRepository.getChildComments(widget.parentCommentId, pageParameters);
    if(res.length<pageParameters.pageSize) {
      if(!mounted) return;
      setState(() {
        isLoadMoreAvailable = false;
      });
    }
    for(var element in res) {
      CommentController controller = CommentController();
      childCommentControllers.add(controller);
    }
    if (!mounted) return;
    childComments.addAll(res);
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
    pageParameters.pageNumber++;
  }

  double lineWidth=1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExceptionsBloc, ExceptionsState>(builder: (context, state) {
      return Stack(children: [
        Positioned(
          left: 11,
          top: 0,
          bottom: 0,
          child: Container(
            width: lineWidth,
            color: widget.isMovedToTop ? Theme.of(context).textTheme.titleMedium!.color! : Theme.of(context).textTheme.displaySmall!.color!,
          ),
        ),
        if(widget.isMovedToTop)
        Positioned(
          left: 11+lineWidth,
          top: 0,
          child: Container(
            width: 21*3,
            height: lineWidth,
            color: widget.isMovedToTop ? Theme.of(context).textTheme.titleMedium!.color! : Theme.of(context).textTheme.displaySmall!.color!,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  cacheExtent: 9999,
                  itemCount: childComments.length + 1,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index < childComments.length) {
                      return CommentCardWidget(
                        numberFormatingService: getIt<NumberFormatingService>(),
                        comment: childComments[index],
                        commentsRepository: widget.commentsRepository,
                        timeFormatingService: getIt<TimeFormatingService>(),
                        postId: widget.postId,
                        postOwnerId: widget.postOwnerId,
                        parentCommentId: widget.parentCommentId,
                        mainParent: widget.mainParent,
                        depth: widget.depth + 1,
                        parentCommentController: childCommentControllers[index],
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
                    if (state.isException && state.exceptionType == ExceptionTypes.serverError) {
                      return ServerErrorNotificationSectionWidget(
                        onPressed: () {
                          loadFirst();
                        },
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
              ],
            ))
      ]);
    });
  }
}
