import 'package:dio/dio.dart';
import 'package:mtaa_frontend/core/services/exceptions_service.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/get_location_points_request.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/simple_location_point_response.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/location_post_response.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';
import 'package:uuid/uuid.dart';

abstract class LocationsApi {
  Future<List<SimpleLocationPointResponse>> getLocationPoints(GetLocationPointsRequest request);
  Future<List<LocationPostResponse>> getClusterLocationPoints(UuidValue clusterId, PageParameters pageParameters);
  Future<LocationPostResponse?> getLocationPostById(UuidValue id);
}

class LocationsApiImpl extends LocationsApi {
  final Dio dio;
  final String controllerName = 'Locations';
  final ExceptionsService exceptionsService;
  CancelToken cancelToken = CancelToken();

  LocationsApiImpl(this.dio, this.exceptionsService);

  @override
  Future<List<SimpleLocationPointResponse>> getLocationPoints(GetLocationPointsRequest request) async {
    final fullUrl = '$controllerName/get-points';
    try {
      var res = await dio.post(fullUrl, data: request.toJson());
      List<dynamic> data = res.data;
      return data.map((item) => SimpleLocationPointResponse.fromJson(item)).toList();
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return [];
    }
  }

  @override
  Future<List<LocationPostResponse>> getClusterLocationPoints(UuidValue clusterId, PageParameters pageParameters) async {
    final fullUrl = '$controllerName/get-cluster-posts/${clusterId.uuid}';
    try {
      var res = await dio.post(fullUrl, data: pageParameters.toJson());
      List<dynamic> data = res.data;
      return data.map((item) => LocationPostResponse.fromJson(item)).toList();
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return [];
    }
  }

  @override
  Future<LocationPostResponse?> getLocationPostById(UuidValue id) async{
    final fullUrl = '$controllerName/get-location-post/${id.uuid}';
    try {
      var res = await dio.get(fullUrl);
      return LocationPostResponse.fromJson(res.data);
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return null;
    }
  }
}
