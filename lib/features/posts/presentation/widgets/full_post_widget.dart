import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/images/image_size_type.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/core/services/number_formating_service.dart';
import 'package:mtaa_frontend/core/services/time_formating_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/comments/presentation/widgets/post_comment_icon_widget.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/location_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/post_like_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';

class FullPostWidget extends StatefulWidget {
  final FullPostResponse post;
  final TimeFormatingService timeFormatingService;
  final bool isFull;
  final PostsRepository repository;
  final LocationsRepository locationsRepository;
  final MyToastService toaster;
  final TokenStorage tokenStorage;

  const FullPostWidget({super.key,
  required this.post,
  required this.timeFormatingService,
  required this.isFull,
  required this.repository,
  required this.locationsRepository,
  required this.toaster,
  required this.tokenStorage});

  @override
  State<FullPostWidget> createState() => _FullPostWidgetState();
}

class _FullPostWidgetState extends State<FullPostWidget> {
  CarouselSliderController carouselController = CarouselSliderController();

  bool isNextImageAllowed = false;
  bool isTextOpen = false;
  int currentPos = 0;
  late int maxPos;
  late String userId = '';

  bool isSaved = false;

  List<MyImageGroupResponse> images = [];

  @override
  void initState() {
    super.initState();
    if (widget.post.images.length > 1) {
      isNextImageAllowed = true;
    }
    maxPos = widget.post.images.length - 1;
    images = widget.post.images;
    Future.microtask(() async {
      var uId = await widget.tokenStorage.getUserId();
      if (!mounted) return;
      if (uId != null) {
        userId = uId;
      }
      if (widget.post.locationId != null) {
        bool isSavedRes = await widget.repository.isLocationPostSaved(widget.post.id);
        if (!mounted) return;
        setState(() {
          isSaved = isSavedRes;
        });
      }
    });
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

  var isDeleteLoading = false;
  Future deleteMicrotask() async {
    if (!mounted) return;
    setState(() {
      isDeleteLoading = true;
    });
    if (!mounted) return;
    var res = await widget.repository.deletePost(widget.post.id);
    if (!mounted) return;
    setState(() {
      isDeleteLoading = false;
    });
    if (res) {
      if (!mounted) return;
      widget.toaster.showMsg('Post deleted successfully');
      if (!mounted || !context.mounted) return;
      GoRouter.of(context).go(userRecommendationsScreenRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    GoRouter.of(context).push(publicAccountInformationScreenRoute, extra: widget.post.owner.id);
                  },
                  child: Row(
                    children: [
                      if (widget.post.owner.avatar != null)
                        ClipOval(
                          child: Image(
                            image: getImage(widget.post.owner.avatar!.images.firstWhere((element) => element.type == ImageSizeType.small)),
                            width: 31,
                            height: 31,
                          ),
                        ),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.owner.displayName,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.timeFormatingService.formatTimeAgo(widget.post.dataCreationTime),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<PostMenuElements>(
                  initialValue: null,
                  onSelected: (PostMenuElements item) {
                    if (item == PostMenuElements.edit) {
                      GoRouter.of(context).push(updatePostScreenRoute, extra: widget.post);
                    } else if (item == PostMenuElements.delete) {
                      deleteMicrotask();
                    }
                    if (!mounted) return;
                    setState(() {});
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<PostMenuElements>>[
                    PopupMenuItem<PostMenuElements>(value: PostMenuElements.share, child: Text('Share', style: Theme.of(context).textTheme.bodyMedium)),
                    if (userId == widget.post.owner.id) PopupMenuItem<PostMenuElements>(value: PostMenuElements.edit, child: Text('Edit', style: Theme.of(context).textTheme.bodyMedium)),
                    if (userId == widget.post.owner.id)
                      PopupMenuItem<PostMenuElements>(value: PostMenuElements.delete, child: isDeleteLoading ? DotLoader() : Text('Delete', style: Theme.of(context).textTheme.bodyMedium)),
                  ],
                ),
              ],
            )),
        Stack(
          fit: StackFit.loose,
          alignment: AlignmentDirectional.center,
          children: [
            GestureDetector(
              onTap: () {
                if (widget.isFull) return;
                GoRouter.of(context).push("$fullPostScreenRoute/${widget.post.id}", extra: widget.post);
              },
              child: CarouselSlider(
                  items: [for (var image in images) Image(fit: BoxFit.fitWidth, image: getImage(image.images.firstWhere((element) => element.type == ImageSizeType.large)))],
                  carouselController: carouselController,
                  disableGesture: false,
                  options: CarouselOptions(
                    initialPage: 0,
                    viewportFraction: 0.999999999999,
                    reverse: false,
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    aspectRatio: widget.post.images.first.images.firstWhere((element) => element.type == ImageSizeType.large).aspectRatio,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) => setState(() {
                      currentPos = index;
                    }),
                  )),
            ),
            if (currentPos < maxPos)
              Positioned(
                right: 0,
                child: IconButton(
                  onPressed: () {
                    if (currentPos < maxPos) {
                      carouselController.nextPage(duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
                    }
                  },
                  style: Theme.of(context).iconButtonTheme.style!.copyWith(iconColor: WidgetStateProperty.all(secondary1InvincibleColor)),
                  icon: SvgPicture.asset('assets/icons/arrow_right.svg', width: 24, height: 24, colorFilter: ColorFilter.mode(secondary1InvincibleColor, BlendMode.srcIn)),
                ),
              ),
            if (currentPos > 0)
              Positioned(
                  left: 0,
                  child: IconButton(
                      onPressed: () {
                        if (currentPos > 0) {
                          carouselController.previousPage(duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
                        }
                      },
                      style: Theme.of(context).iconButtonTheme.style!.copyWith(iconColor: WidgetStateProperty.all(secondary1InvincibleColor)),
                      icon: SvgPicture.asset('assets/icons/arrow_left.svg', width: 24, height: 24, colorFilter: ColorFilter.mode(secondary1InvincibleColor, BlendMode.srcIn)))),
            if (widget.post.images.length > 1)
              Positioned(
                bottom: 10,
                child: Row(
                  children: [
                    for (int i = 0; i < widget.post.images.length; i++)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: currentPos == i ? secondary1InvincibleColor : secondary1InvincibleColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                PostLikeWidget(repository: getIt<PostsRepository>(), numberFormatingService: getIt<NumberFormatingService>(), post: widget.post),
                GestureDetector(
                    onTap: () {
                      if (widget.isFull) return;
                      GoRouter.of(context).push("$fullPostScreenRoute/${widget.post.id}", extra: widget.post);
                    },
                    child: PostCommentIconWidget(
                      numberFormatingService: getIt<NumberFormatingService>(),
                      initialCommentsCount: widget.post.commentsCount,
                      postId: widget.post.id,
                    )),
              ],
            ),
            if (widget.post.locationId != null)
              Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
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
                          if (!mounted) return;
                          setState(() {
                            isSaved = !isSaved;
                          });

                          bool res = false;

                          if (isSaved) {
                            LocationPostResponse? post = await widget.locationsRepository.getLocationPostById(widget.post.locationId!);

                            if (post != null) {
                              await widget.repository.saveLocationPost(post);
                              res = true;
                            }
                          } else {
                            LocationPostResponse? post = await widget.locationsRepository.getLocationPostById(widget.post.locationId!);

                            if (post != null) {
                              await widget.repository.removeLocationPost(post);
                              res = true;
                            }
                          }
                          if (!res) {
                            if (!mounted) return;
                            setState(() {
                              isSaved = !isSaved;
                            });
                          }
                        },
                      ))),
          ],
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 11),
            child: Text.rich(
                textAlign: TextAlign.start,
                TextSpan(
                  text: widget.post.description.length <= 200 || isTextOpen || widget.isFull ? widget.post.description : '${widget.post.description.substring(0, 200)}... ',
                  style: Theme.of(context).textTheme.bodySmall,
                  children: [
                    if (widget.post.description.length > 200 && !widget.isFull)
                      TextSpan(
                        text: isTextOpen ? ' less' : 'more',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 10),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              isTextOpen = !isTextOpen;
                            });
                          },
                      ),
                  ],
                ))),
        const SizedBox(height: 11),
      ],
    );
  }
}

enum PostMenuElements { delete, edit, share }
