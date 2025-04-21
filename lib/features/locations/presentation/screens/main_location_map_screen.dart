import 'dart:async';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
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
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/get_location_points_request.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/simple_location_point_response.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:open_settings_plus/core/open_settings_plus.dart';

class MainLocationMapScreen extends StatefulWidget {
  final LocationsRepository repository;
  final MyToastService toastService;
  const MainLocationMapScreen({super.key, required this.repository, required this.toastService});

  @override
  State<MainLocationMapScreen> createState() => _MainLocationMapScreenState();
}

class _MainLocationMapScreenState extends State<MainLocationMapScreen> {
  late AppLifecycleListener listener;

  final locationController = StreamController<LocationMarkerPosition>.broadcast();
  Stream<LocationMarkerPosition> userLocationStream = Stream.empty();
  Position? userPos;

  bool isGPSEnabled = false;
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

    initLocation();
  }

  @override
  void dispose() {
    listener.dispose();
    debounceTimer?.cancel();
    locationController.close();
    super.dispose();
  }

  Future<void> loadPoints() async {
    if (isLoading) return;
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

  Future initLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        await loadLastPosition();
        await moveToCurrentUserPosition();
        return;
      }
    }

    var isGpsEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isGpsEnabled) {
      await loadLastPosition();
      await moveToCurrentUserPosition();
      listenForGPS();
    } else {
      startPositionStream();
    }
  }

  Future loadLastPosition() async {
    if (!mounted) return;
    setState(() {
      userPos = Position(
          accuracy: 100,
          altitude: 0,
          heading: 0,
          latitude: 30.0,
          longitude: 38.0,
          speed: 0,
          speedAccuracy: 0,
          timestamp: DateTime.now(),
          altitudeAccuracy: 100,
          isMocked: false,
          headingAccuracy: 100,
          floor: 0);
      locationController.add(LocationMarkerPosition(latitude: userPos!.latitude, longitude: userPos!.longitude, accuracy: userPos!.accuracy));
      userLocationStream = locationController.stream;
    });
  }

  void debouncedLoadPoints() {
    debounceTimer?.cancel();

    debounceTimer = Timer(const Duration(milliseconds: 300), () {
      loadPoints();
    });
  }

  Future moveToCurrentUserPosition() async {
    if (userPos == null) return;

    mapController.move(LatLng(userPos!.latitude, userPos!.longitude), mapController.camera.zoom);
  }

  void startPositionStream() {
    isGPSEnabled = true;
    userLocationStream = Geolocator.getPositionStream().map((Position position) {
      final locationMarker = LocationMarkerPosition(latitude: position.latitude, longitude: position.longitude, accuracy: position.accuracy);
      userPos = position;

      return locationMarker;
    });

    setState(() {});
  }

  Future setCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return;
      }
    }

    if (!mounted) return;
    setState(() {
      userPos = Position(
          accuracy: 100,
          altitude: 0,
          heading: 0,
          latitude: 30.0,
          longitude: 38.0,
          speed: 0,
          speedAccuracy: 0,
          timestamp: DateTime.now(),
          altitudeAccuracy: 100,
          isMocked: false,
          headingAccuracy: 100,
          floor: 0);
      locationController.add(LocationMarkerPosition(latitude: userPos!.latitude, longitude: userPos!.longitude, accuracy: userPos!.accuracy));
      userLocationStream = locationController.stream;
    });
  }

  void listenForGPS() {
    Geolocator.getServiceStatusStream().listen((status) {
      if (status == ServiceStatus.enabled) {
        isGPSEnabled = true;
        setCurrentPosition();
      } else {
        isGPSEnabled = false;
      }
    });

    Geolocator.checkPermission().then((permission) {
      if (permission != LocationPermission.denied && permission != LocationPermission.deniedForever) {
        Geolocator.isLocationServiceEnabled().then((enabled) {
          if (enabled) {
            isGPSEnabled = true;
            setCurrentPosition();
          } else {
            isGPSEnabled = false;
          }
        });
      }
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
                  positionStream: userLocationStream,
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
                  onPressed: () {
                    GoRouter.of(context).push(locationClusterPointsScreenRoute);
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
          onPressed: () async {
            if (!isGPSEnabled) {
              switch (OpenSettingsPlus.shared) {
                case OpenSettingsPlusAndroid settings:
                  settings.locationSource();
                  break;
                case OpenSettingsPlusIOS settings:
                  settings.locationServices();
                  break;
                default:
                  throw Exception('Platform not supported');
              }
            }

            moveToCurrentUserPosition();
          },
          child: Icon(Icons.my_location),
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
