import 'package:mtaa_frontend/domain/hive_data/locations/user_position_hive.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/get_location_points_request.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/simple_location_point_response.dart';
import 'package:mtaa_frontend/features/locations/data/network/locations_api.dart';
import 'package:mtaa_frontend/features/locations/data/storages/locations_storage.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/location_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/storages/posts_storage.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';
import 'package:uuid/uuid_value.dart';

abstract class LocationsRepository {
  Future<List<SimpleLocationPointResponse>> getLocationPoints(GetLocationPointsRequest request);
  Future<List<LocationPostResponse>> getClusterLocationPoints(UuidValue clusterId, PageParameters pageParameters);
  Future<LocationPostResponse?> getLocationPostById(UuidValue id);

  Future<List<SimpleLocationPointResponse>> getPreviousLocationPoints();
  Future setPreviousLocationPoints(List<SimpleLocationPointResponse> points);
  Future<UserPositionHive?> getPreviousUserPosition();
  Future setPreviousUserPosition(UserPositionHive userPosition);
}

class LocationsRepositoryImpl extends LocationsRepository {
  final LocationsApi api;
  final LocationsStorage locationsStorage;
  final PostsStorage postsStorage;

  LocationsRepositoryImpl(this.api, this.postsStorage, this.locationsStorage);

  @override
  Future<List<SimpleLocationPointResponse>> getLocationPoints(GetLocationPointsRequest request) async {
    return await api.getLocationPoints(request);
  }

  @override
  Future<List<LocationPostResponse>> getClusterLocationPoints(UuidValue clusterId, PageParameters pageParameters) async {
    return await api.getClusterLocationPoints(clusterId, pageParameters);
  }

  @override
  Future<LocationPostResponse?> getLocationPostById(UuidValue id) async {
    var post = await postsStorage.getSavedLocationPostById(id);
    if(post!=null)return post;

    return await api.getLocationPostById(id);
  }


  @override
  Future<List<SimpleLocationPointResponse>> getPreviousLocationPoints() async {
    return await locationsStorage.getPreviousLocationPoints();
  }

  @override
  Future setPreviousLocationPoints(List<SimpleLocationPointResponse> points) async {
    await locationsStorage.setPreviousLocationPoints(points);
  }

  @override
  Future<UserPositionHive?> getPreviousUserPosition() async{
    return await locationsStorage.getPreviousUserPosition();
  }

  @override
  Future setPreviousUserPosition(UserPositionHive userPrevLocation) async{
    await locationsStorage.setPreviousUserPosition(userPrevLocation);
  }
}
