import 'dart:async';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/get_location_points_request.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/simple_location_point_response.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';

class MainLocationMapScreen extends StatefulWidget {
  final LocationsRepository repository;
  const MainLocationMapScreen({super.key, required this.repository});

  @override
  State<MainLocationMapScreen> createState() => _MainLocationMapScreenState();
}

class _MainLocationMapScreenState extends State<MainLocationMapScreen> {
  late AppLifecycleListener listener;

  final MapController mapController = MapController();
  List<SimpleLocationPointResponse> locationPoints = [];
  bool isLoading = false;
  Timer? debounceTimer;

  @override
  void initState() {
    super.initState();

    if (getIt.isRegistered<BuildContext>()) {
      getIt.unregister<BuildContext>();
    }
    getIt.registerSingleton<BuildContext>(context);

    listener = AppLifecycleListener(
      onResume: () async {
        if (!mounted) return;
        Future.microtask(() async {
          if (context.mounted && mounted) {
            final status = await AirplaneModeChecker.instance.checkAirplaneMode();
            if (status == AirplaneModeStatus.off && mounted) {
              context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''));
            }
          }
        });
      },
    );
  }

  @override
  void dispose() {
    listener.dispose();
    debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> loadPoints() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });

    final center = mapController.camera.center;
    final zoom = mapController.camera.zoom.round();

    final radius = 100_000 * (20 - zoom);

    final request = GetLocationPointsRequest(
      latitude: center.latitude,
      longitude: center.longitude,
      radius: radius.toDouble(),
      zoomLevel: zoom,
    );

    final points = await widget.repository.getLocationPoints(request);

    setState(() {
      locationPoints = points;
      isLoading = false;
    });
  }

  void debouncedLoadPoints() {
    debounceTimer?.cancel();

    debounceTimer = Timer(const Duration(milliseconds: 300), () {
      loadPoints();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            SvgPicture.asset(
              'assets/svgs/small_logo.svg',
              height: 24,
            ),
            const SizedBox(width: 4),
            SvgPicture.asset(
              'assets/svgs/logo_text_white.svg',
              height: 18,
            ),
          ]),
          actions: <Widget>[],
        ),
        body: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialZoom: 10,
                onMapReady: () {
                  loadPoints();
                },
                onMapEvent: (event) {
                  if (event is MapEventDoubleTapZoom) {
                    loadPoints();
                  } else if (event is MapEventMove || event is MapEventRotate) {
                    debouncedLoadPoints();
                  }
                },
              ),
              children: [
                TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', userAgentPackageName: 'com.example.app'),
                MarkerLayer(
                  markers: locationPoints
                      .map((point) => Marker(
                            point: LatLng(point.latitude, point.longitude),
                            width: 40.0,
                            height: 40.0,
                            child: buildPoint(point),
                          ))
                      .toList(),
                ),
                CurrentLocationLayer(
                  alignPositionOnUpdate: AlignOnUpdate.once,
                ),
              ],
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            Positioned(
                top: 13,
                child: TextButton(
                  style: Theme.of(context).textButtonTheme.style?.copyWith(
                        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(10)),
                        minimumSize: WidgetStateProperty.all(Size.zero),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                          ),
                        ),
                      ),
                  onPressed: () => {
                    GoRouter.of(context).push(globalSearchScreenRoute).then(
                      (value) {
                        if (locationPoints.isEmpty && !isLoading) loadPoints();
                      },
                    )
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.collections_bookmark_outlined, color: whiteColor, size: 36),
                      Text('Saved',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: whiteColor,
                              )),
                    ],
                  ),
                )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: loadPoints,
          child: const Icon(Icons.refresh),
        ),
        bottomNavigationBar: PhoneBottomMenu(sellectedType: MenuButtons.Map));
  }

  Widget buildPoint(SimpleLocationPointResponse point) {
    if (point.childCount > 0) {
      return GestureDetector(
          onTap: () => {
                GoRouter.of(context).push('$locationClusterPointsScreenRoute/${point.id.uuid}'),
              },
          child: Container(
            decoration: BoxDecoration(
              color: lightThird2Color.withAlpha(200),
              shape: BoxShape.circle,
              border: Border.all(color: whiteColor, width: 2),
            ),
            child: Center(
              child: Text('${point.childCount + 1}',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: whiteColor,
                      )),
            ),
          ));
    } else {
      return GestureDetector(
          onTap: () => {
                GoRouter.of(context).push('$fullPostScreenRoute/${point.postId}'),
              },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              point.image!.fullPath,
              fit: BoxFit.cover,
            ),
          ));
    }
  }
}
