import 'package:dio/dio.dart';
import 'package:mtaa_frontend/features/images/data/models/requests/update_image_request.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/update_location_request.dart';
import 'package:uuid/uuid.dart';

class UpdatePostRequest {
  final UuidValue id;
  final List<UpdateImageRequest> images;
  final String description;
  final UpdateLocationRequest? location;

  UpdatePostRequest({
    required this.id,
    required this.images,
    required this.description,
    this.location
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id.uuid,
      'images': images.map((image) => image.toJson()).toList(),
      'description': description,
      'location': location?.toJson(),
    };
  }

  FormData toFormData() {
    return FormData.fromMap({
      'id':id.uuid,
      'images': images.map((image) => image.toFormData()).toList(),
      'description': description,
      'location': location?.toJson(),
    });
  }
}
