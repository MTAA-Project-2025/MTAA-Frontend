import 'package:hive/hive.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/add_location_request.dart';


part 'add_location_hive.g.dart';

@HiveType(typeId: 6)
class AddLocationHive extends HiveObject{

  @HiveField(0)
  double latitude;

  @HiveField(1)
  double longitude;

  @HiveField(2)
  DateTime eventTime;

  AddLocationHive({
    this.latitude = -200,
    this.longitude = -200,
    required this.eventTime,
  });

  factory AddLocationHive.fromRequest(AddLocationRequest request){
    return AddLocationHive(
        latitude: request.latitude,
        longitude: request.longitude,
        eventTime: request.eventTime,
    );
  }
}
