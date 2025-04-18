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
}
