import 'dart:async';
import 'package:flutter/material.dart';
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
import 'package:mtaa_frontend/features/locations/data/models/responses/location_point_type.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/simple_location_point_response.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/locations/presentation/widgets/map_widget.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/location_post_response.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:uuid/uuid_value.dart';

class OnePointScreenScreen extends StatefulWidget {
  final LocationsRepository repository;
  final MyToastService toastService;
  final SimpleLocationPointResponse? point;
  final UuidValue? pointId;
  const OnePointScreenScreen({super.key, required this.repository, required this.toastService, this.point, this.pointId});

  @override
  State<OnePointScreenScreen> createState() => _OnePointScreenScreenState();
}

class _OnePointScreenScreenState extends State<OnePointScreenScreen> {
  List<SimpleLocationPointResponse> locationPoints = [];
  bool isLoading = false;

  final mapController = MapController();

  @override
  void initState() {
    super.initState();

    if (getIt.isRegistered<BuildContext>()) {
      getIt.unregister<BuildContext>();
    }
    getIt.registerSingleton<BuildContext>(context);

    initialize();
  }

  Future initialize() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });

    List<SimpleLocationPointResponse> points = [];

    if (widget.point != null) {
      points.add(widget.point!);
    } else if (widget.pointId != null) {
      LocationPostResponse? post = await widget.repository.getLocationPostById(widget.pointId!);
      if (post != null) {
        points.add(SimpleLocationPointResponse(
            id: widget.pointId!,
            latitude: post.point.latitude,
            longitude: post.point.longitude,
            image: post.point.image,
            childCount: 0,
            postId: post.id,
            type: LocationPointType.point,
            zoomLevel: 13));
      }
    }
    if (!mounted) return;
    setState(() {
      locationPoints = points;
      isLoading = false;
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
        body: MapWidget(
          repository: widget.repository,
          toastService: widget.toastService,
          onMapReady: () {
            if (locationPoints.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                mapController.move(LatLng(locationPoints[0].latitude, locationPoints[0].longitude), locationPoints[0].zoomLevel + 0.0);
              });
            }
          },
          onMapEvent: (event) {},
          locationPoints: locationPoints,
          mapController: mapController,
          isLoading: isLoading,
          onDispose: (Position userPos) {},
          isUserPos: false,
          isDisplaySavedLocations: false,
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
