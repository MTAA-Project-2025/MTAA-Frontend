import 'package:mtaa_frontend/domain/hive_data/add-posts/add_location_hive.dart';

class AddLocationRequest {
  double latitude;
  double longitude;
  DateTime eventTime;

  AddLocationRequest({
    this.latitude = -200,
    this.longitude = -200,
    required this.eventTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'eventTime': eventTime.toIso8601String(),
    };
  }

  factory AddLocationRequest.fromHive(AddLocationHive hive){
    return AddLocationRequest(
      latitude: hive.latitude,
      longitude: hive.longitude,
      eventTime: hive.eventTime,
    );
  }
}
