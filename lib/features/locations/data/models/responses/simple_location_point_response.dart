import 'package:mtaa_frontend/domain/hive_data/locations/simple_point_hive.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/location_point_type.dart';
import 'package:uuid/uuid.dart';

class SimpleLocationPointResponse {
  final UuidValue id;
  final UuidValue? postId;
  final double longitude;
  final double latitude;
  final LocationPointType type;
  final int zoomLevel;
  final int childCount;
  final MyImageResponse? image;
  
  SimpleLocationPointResponse({required this.id,
  this.postId,
  required this.longitude,
  required this.latitude,
  required this.type,
  required this.zoomLevel,
  required this.childCount,
  this.image});

  factory SimpleLocationPointResponse.fromJson(Map<String, dynamic> json) {
    return SimpleLocationPointResponse(
      id: UuidValue.fromString(json['id']),
      postId: json['postId']==null?null:UuidValue.fromString(json['postId']),
      longitude: json['longitude'],
      latitude: json['latitude'],
      type: LocationPointType.values[json['type']],
      zoomLevel: json['zoomLevel'],
      childCount: json['childCount'],
      image: json['image'] == null ? null : MyImageResponse.fromJson(json['image']),
    );
  }

  factory SimpleLocationPointResponse.fromHive(SimplePointHive hive) {
    return SimpleLocationPointResponse(
      id: UuidValue.fromString(hive.id),
      postId: hive.postId==null?null:UuidValue.fromString(hive.postId!),
      longitude: hive.longitude,
      latitude: hive.latitude,
      type: LocationPointType.values[hive.type],
      zoomLevel: hive.zoomLevel,
      childCount: hive.childCount,
      image: hive.image == null ? null : MyImageResponse.fromHive(hive.image!),
    );
  }
}
