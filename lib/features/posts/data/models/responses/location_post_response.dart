import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/simple_location_point_response.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/simple_post_response.dart';
import 'package:uuid/uuid.dart';

class LocationPostResponse extends SimplePostResponse{
  final UuidValue? locationId;
  final DateTime eventTime;
  final SimpleLocationPointResponse point;
  final String description;
  final String ownerDisplayName;

  bool isSaved=false;

  LocationPostResponse({
    required super.id,
    required super.smallFirstImage,
    required super.dataCreationTime,
    this.locationId,
    required this.eventTime,
    required this.point,
    required this.description,
    required this.ownerDisplayName
  });

  factory LocationPostResponse.fromJson(Map<String, dynamic> json) {
    return LocationPostResponse(
      id: UuidValue.fromString(json['id']),
      description: json['description'],
      smallFirstImage: MyImageResponse.fromJson(json['smallFirstImage']),
      dataCreationTime: DateTime.parse(json['dataCreationTime']),
      locationId: json['locationId'] == null ? null : UuidValue.fromString(json['locationId']),
      eventTime: DateTime.parse(json['eventTime']),
      point: SimpleLocationPointResponse.fromJson(json['point']),
      ownerDisplayName: json['ownerDisplayName'],
    );
  }
}