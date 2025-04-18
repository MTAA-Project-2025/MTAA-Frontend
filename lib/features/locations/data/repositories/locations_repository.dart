import 'package:mtaa_frontend/features/locations/data/models/requests/get_location_points_request.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/simple_location_point_response.dart';
import 'package:mtaa_frontend/features/locations/data/network/locations_api.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/location_post_response.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';
import 'package:uuid/uuid_value.dart';

abstract class LocationsRepository {
  Future<List<SimpleLocationPointResponse>> getLocationPoints(GetLocationPointsRequest request);
  Future<List<LocationPostResponse>> getClusterLocationPoints(UuidValue clusterId, PageParameters pageParameters);
}

class LocationsRepositoryImpl extends LocationsRepository {
  final LocationsApi api;

  LocationsRepositoryImpl(this.api);

  @override
  Future<List<SimpleLocationPointResponse>> getLocationPoints(GetLocationPointsRequest request) async {
    return await api.getLocationPoints(request);
  }

  @override
  Future<List<LocationPostResponse>> getClusterLocationPoints(UuidValue clusterId, PageParameters pageParameters) async {
    return await api.getClusterLocationPoints(clusterId, pageParameters);
  }
}
