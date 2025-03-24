import 'package:dio/dio.dart';
import 'package:mtaa_frontend/features/images/data/models/requests/add_image_request.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/add_location_request.dart';

class AddPostRequest {
  final List<AddImageRequest> images;
  final String description;
  final AddLocationRequest? location;

  AddPostRequest({
    required this.images,
    required this.description,
    this.location
  });

  Map<String, dynamic> toJson() {
    return {
      'images': images.map((image) => image.toJson()).toList(),
      'description': description,
      'location': location?.toJson(),
    };
  }
  
  FormData toFormData() {
    return FormData.fromMap({
      'images': images.map((image) => image.toFormData()).toList(),
      'description': description,
      'location': location?.toJson(),
    });
  }
}
