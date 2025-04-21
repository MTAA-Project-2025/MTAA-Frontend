import 'package:hive/hive.dart';
import 'package:mtaa_frontend/core/constants/storages/storage_boxes.dart';
import 'package:mtaa_frontend/domain/hive_data/locations/simple_point_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/locations/user_position_hive.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/simple_location_point_response.dart';

abstract class LocationsStorage {
  Future<List<SimpleLocationPointResponse>> getPreviousLocationPoints();
  Future setPreviousLocationPoints(List<SimpleLocationPointResponse> points);
  Future<UserPositionHive?> getPreviousUserPosition();
  Future setPreviousUserPosition(UserPositionHive userPosition);
}

class LocationsStorageImpl extends LocationsStorage {
  final String mapPrevPoints = 'mapPrevPoints';
  final String userMapPrevLoc = 'userMapPrevLoc';

  LocationsStorageImpl();

  @override
  Future<List<SimpleLocationPointResponse>> getPreviousLocationPoints() async {
    var box = await Hive.openBox<List>(locationPointsDataBox);

    List<dynamic>? points = box.get(mapPrevPoints);
    if (points == null) return [];
    return points.map((e) => SimpleLocationPointResponse.fromHive(e)).toList();
  }

  @override
  Future setPreviousLocationPoints(List<SimpleLocationPointResponse> points) async {
    var box = await Hive.openBox<List>(locationPointsDataBox);

    List<SimplePointHive> hivePoints = points.map((e) => SimplePointHive.fromResponse(e)).toList();
    await box.put(mapPrevPoints, hivePoints);
  }

  @override
  Future<UserPositionHive?> getPreviousUserPosition() async{
    var box = Hive.box<UserPositionHive>(prevUserLocationDataBox);
    return box.get(userMapPrevLoc);
  }

  @override
  Future setPreviousUserPosition(UserPositionHive userPrevLocation) async{
    var box = await Hive.openBox<UserPositionHive>(prevUserLocationDataBox);
    await box.put(userMapPrevLoc, userPrevLocation);
  }
}
