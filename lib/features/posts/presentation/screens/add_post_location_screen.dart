import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:mtaa_frontend/core/constants/images/image_size_type.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/add_location_request.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/location_point_type.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/simple_location_point_response.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/locations/presentation/widgets/map_widget.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/full_data_time_input.dart';
import 'package:uuid/uuid.dart';

class AddPostLocationScreen extends StatefulWidget {
  final MyToastService toastService;
  final AddLocationRequest addLocationRequest;

  const AddPostLocationScreen({super.key, required this.toastService, required this.addLocationRequest});

  @override
  State<AddPostLocationScreen> createState() => _AddPostLocationScreenState();
}

class _AddPostLocationScreenState extends State<AddPostLocationScreen> {
  DateTime? selectedDate;
  final GlobalKey<FormState> birthDateFormKey = GlobalKey<FormState>();
  final mapController = MapController();

  SimpleLocationPointResponse? selectedLocationPoint;

  @override
  void initState() {
    super.initState();

    if (getIt.isRegistered<BuildContext>()) {
      getIt.unregister<BuildContext>();
    }
    getIt.registerSingleton<BuildContext>(context);

    if (widget.addLocationRequest.latitude > -200) {
      selectedLocationPoint = SimpleLocationPointResponse(
          childCount: 0,
          id: UuidValue.fromString(Uuid().v4()),
          latitude: widget.addLocationRequest.latitude,
          longitude: widget.addLocationRequest.longitude,
          zoomLevel: 12,
          type: LocationPointType.point,
          image: MyImageResponse(id: '', shortPath: '', fullPath: '', fileType: '', height: 1, width: 1, aspectRatio: 1, type: ImageSizeType.small));
    }
  }

  void navigateBack() {
    Future.microtask(() async {
      if (!mounted && !context.mounted) return;
      GoRouter.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post event'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Text(
              'Add post event',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 18),
            Center(
              child: SizedBox(
                  height: 65,
                  child: FullDateTimeInput(
                    placeholder: 'Event date',
                    onChanged: (date) async {
                      if (!mounted) return;
                      if (date.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch) {
                        widget.toastService.showErrorWithContext('Please select a valid date in the future', context);
                        return;
                      }
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    minDate: DateTime.now().subtract(Duration(days: 1)),
                    maxDisplayedDate: DateTime.now().add(Duration(days: 356)),
                    maxDate: DateTime.now().add(Duration(days: 356)),
                    initialDate: widget.addLocationRequest.eventTime,
                    initialIsFirstTime: widget.addLocationRequest.latitude > -200 ? false : true,
                  )),
            ),
            const SizedBox(height: 19),
            SizedBox(
                height: 500,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: MapWidget(
                        repository: getIt<LocationsRepository>(),
                        toastService: widget.toastService,
                        onMapReady: () {},
                        onMapEvent: (MapEvent m) {},
                        locationPoints: selectedLocationPoint == null ? [] : [selectedLocationPoint!],
                        isLoading: false,
                        mapController: mapController,
                        onTap: (TapPosition pos, LatLng latPos) {
                          setState(() {
                            selectedLocationPoint = SimpleLocationPointResponse(
                              childCount: 0,
                              id: UuidValue.fromString(Uuid().v4()),
                              latitude: latPos.latitude,
                              longitude: latPos.longitude,
                              zoomLevel: 10,
                              type: LocationPointType.point,
                              image: MyImageResponse(id: '', shortPath: '', fullPath: '', fileType: '', height: 1, width: 1, aspectRatio: 1, type: ImageSizeType.small),
                            );
                          });
                        },
                        isDisplaySavedLocations: false))),
            const SizedBox(height: 19),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    navigateBack();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Text(
                    'Cancel',
                  ),
                ),
                const SizedBox(width: 5),
                TextButton(
                  onPressed: () async {
                    if (selectedDate == null) {
                      widget.toastService.showErrorWithContext('Please select an event date', context);
                      return;
                    }
                    if (selectedLocationPoint == null) {
                      widget.toastService.showErrorWithContext('Please select a location point', context);
                      return;
                    }
                    widget.addLocationRequest.eventTime = selectedDate!;
                    widget.addLocationRequest.latitude = selectedLocationPoint!.latitude;
                    widget.addLocationRequest.longitude = selectedLocationPoint!.longitude;

                    navigateBack();
                  },
                  style: Theme.of(context).textButtonTheme.style,
                  child: Text(
                    'Save',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
