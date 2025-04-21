import 'dart:async';
import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/services/internet_checker.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/domain/hive_data/locations/user_position_hive.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/get_location_points_request.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/simple_location_point_response.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/locations/presentation/widgets/map_widget.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';

class MainLocationMapScreen extends StatefulWidget {
  final LocationsRepository repository;
  final MyToastService toastService;
  const MainLocationMapScreen({super.key, required this.repository, required this.toastService});

  @override
  State<MainLocationMapScreen> createState() => _MainLocationMapScreenState();
}

class _MainLocationMapScreenState extends State<MainLocationMapScreen> {
  late AppLifecycleListener listener;
  List<SimpleLocationPointResponse> locationPoints = [];
  bool isLoading = false;
  Timer? debounceTimer;

  final mapController = MapController();

  late StreamSubscription<bool> internetSubscription;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    initialize();

    internetSubscription = InternetChecker.connectionStream.listen((connected) {
      if (connected) {
        isConnected = true;
      } else {
        isConnected = false;
      }
    });

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
    internetSubscription.cancel();
    super.dispose();
  }

  Position? userInitPos;
  Future initialize() async {
    if (!mounted) return;
    isConnected = await InternetChecker.isInternetEnabled();
    if (!mounted) return;
    UserPositionHive? userPos = await widget.repository.getPreviousUserPosition();
    if (!mounted) return;
    if (userPos != null) {
      mapController.move(LatLng(userPos.latitude, userPos.longitude), userPos.floor + 0.0);
      userInitPos = Position(
          latitude: userPos.latitude,
          longitude: userPos.longitude,
          timestamp: DateTime.now(),
          accuracy: userPos.accuracy,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0,
          isMocked: true,
          floor: userPos.floor);
    }
    List<SimpleLocationPointResponse> points = await widget.repository.getPreviousLocationPoints();
    setState(() {
      locationPoints = points;
    });
  }

  Future<void> loadPoints() async {
    if (isLoading || !isConnected) return;
    if (!mounted) return;
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

    if (!mounted) return;
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

  Future saveLocation(Position userPos) async {
    await widget.repository.setPreviousLocationPoints(locationPoints);
    await widget.repository.setPreviousUserPosition(UserPositionHive(
      latitude: userPos.latitude,
      longitude: userPos.longitude,
      accuracy: userPos.accuracy,
      floor: mapController.camera.zoom.round(),
    ));
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
        body: MapWidget(
          repository: widget.repository,
          toastService: widget.toastService,
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
          locationPoints: locationPoints,
          mapController: mapController,
          isLoading: isLoading,
          onDispose: (Position userPos) {
            saveLocation(userPos);
          },
          initialUserPos: userInitPos,
        ),
        bottomNavigationBar: PhoneBottomMenu(sellectedType: MenuButtons.Map));
  }

  Widget buildPoint(SimpleLocationPointResponse point) {
    if (point.childCount > 0) {
      return GestureDetector(
          onTap: () {
            GoRouter.of(context).push('$locationClusterPointsScreenRoute/${point.id.uuid}');
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
          onTap: () {
            GoRouter.of(context).push('$fullPostScreenRoute/${point.postId}');
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
