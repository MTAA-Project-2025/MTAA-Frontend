import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/core/services/time_formating_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/comments/bloc/comments_bloc.dart';
import 'package:mtaa_frontend/features/comments/data/repositories/comments_repository.dart';
import 'package:mtaa_frontend/features/comments/presentation/widgets/comments_main_list.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/location_point_type.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/simple_location_point_response.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/locations/presentation/widgets/map_widget.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/location_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/full_post_widget.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_state.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';
import 'package:uuid/uuid_value.dart';

class FullPostScreen extends StatefulWidget {
  final PostsRepository repository;
  final LocationsRepository locationsRepository;
  final String? postId;
  final FullPostResponse? post;
  final TokenStorage tokenStorage;

  const FullPostScreen({super.key, required this.repository, required this.locationsRepository, this.postId, this.post, required this.tokenStorage});

  @override
  State<FullPostScreen> createState() => _FullPostScreenScreenState();
}

class _FullPostScreenScreenState extends State<FullPostScreen> {
  FullPostResponse? post;
  SimpleLocationPointResponse? locationPoint;
  LocationPostResponse? locationPost;
  final mapController = MapController();

  @override
  void initState() {
    super.initState();

    context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''));

    Future.microtask(() async {
      if (!mounted) return;
      final status = await AirplaneModeChecker.instance.checkAirplaneMode();
      if (status == AirplaneModeStatus.on) {
        if (!mounted) return;
        context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
      }
    });

    AppLifecycleListener(
      onResume: () async {
        Future.microtask(() async {
          if (mounted) {
            final status = await AirplaneModeChecker.instance.checkAirplaneMode();
            if (status == AirplaneModeStatus.off) {
              if (!mounted) return;
              context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''));
            }
          }
        });
      },
    );

    initialize();
  }

  Future initialize() async {
    if (widget.post != null) {
      post = widget.post!;
    } else {
      var res = await widget.repository.getFullPostById(UuidValue.fromString(widget.postId!));
      if (!mounted) return;
      if (res != null) {
        setState(() {
          post = res;
        });
      }
    }
    if (!mounted) return;
    if (post != null && post!.locationId != null) {
      locationPost = await widget.locationsRepository.getLocationPostById(post!.locationId!);

      if (locationPost != null) {
        if (!mounted) return;
        setState(() {
          locationPoint = SimpleLocationPointResponse(
              id: locationPost!.point.id,
              latitude: locationPost!.point.latitude,
              longitude: locationPost!.point.longitude,
              image: locationPost!.point.image,
              childCount: 0,
              postId: locationPost!.id,
              type: LocationPointType.point,
              zoomLevel: 13);
        });
      }
    }
  }

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[],
        ),
        body: BlocBuilder<ExceptionsBloc, ExceptionsState>(builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                if (post == null)
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      DotLoader(),
                    ],
                  ),
                if (post != null)
                  FullPostWidget(
                    post: post!,
                    timeFormatingService: getIt<TimeFormatingService>(),
                    isFull: true,
                    repository: widget.repository,
                    locationsRepository: widget.locationsRepository,
                    toaster: getIt<MyToastService>(),
                    tokenStorage: widget.tokenStorage,
                  ),
                if (locationPoint != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Locations', style: Theme.of(context).textTheme.headlineLarge),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              height: 300,
                              child: MapWidget(
                                repository: getIt<LocationsRepository>(),
                                toastService: getIt<MyToastService>(),
                                onMapReady: () {
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    mapController.move(LatLng(locationPoint!.latitude, locationPoint!.longitude), 13);
                                  });
                                },
                                onMapEvent: (MapEvent m) {},
                                locationPoints: [locationPoint!],
                                isLoading: false,
                                mapController: mapController,
                                isDisplaySavedLocations: false,
                                isUserPos: false,
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(children: [
                          Row(
                            children: [
                              Icon(Icons.access_time_outlined),
                              const SizedBox(width: 5),
                              //GPT
                              Text(DateFormat('E, MMM d · h:mm a').format(locationPost!.eventTime), style: Theme.of(context).textTheme.labelSmall),
                            ],
                          ),
                          const SizedBox(height: 5),
                          InkWell(
                            onTap: () {
                              if (locationPost != null) {
                                if (locationPost != null) {
                                  GoRouter.of(context).push(onePointScreenRoute, extra: locationPost!.point);
                                }
                                locationPost!.isSaved = !locationPost!.isSaved;
                              } else if (widget.post != null) {
                                if (widget.post!.locationId != null) {
                                  GoRouter.of(context).push('$onePointScreenRoute/${widget.post!.locationId!.uuid}');
                                }
                              }
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 24,
                                  color: Theme.of(context).textTheme.bodySmall!.color,
                                ),
                                const SizedBox(width: 5),
                                Text("${double.parse((locationPoint!.latitude).toStringAsFixed(7))} ${double.parse((locationPoint!.longitude).toStringAsFixed(7))}",
                                    style: Theme.of(context).textTheme.labelSmall),
                              ],
                            ),
                          )
                        ]),
                      ),
                    ],
                  ),
                if (post != null)
                BlocProvider(
        create: (_) => CommentsBloc(),
        child:
                  Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10, top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Comments', style: Theme.of(context).textTheme.headlineLarge),
                          const SizedBox(height: 10),
                          CommentsMainList(
                            commentsRepository: getIt<CommentsRepository>(),
                            postId: post!.id,
                            postOwnerId: post!.owner.id,
                            tokenStorage: widget.tokenStorage,
                          ),
                        ],
                      )))
              ],
            ),
          );
        }),
        bottomNavigationBar: PhoneBottomMenu(sellectedType: MenuButtons.Home));
  }
}
