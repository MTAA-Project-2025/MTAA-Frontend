import 'package:dio/dio.dart';
import 'package:mtaa_frontend/features/images/data/models/requests/add_image_request.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/add_location_request.dart';
import 'package:uuid/uuid.dart';

class AddPostRequest {
  final List<AddImageRequest> images;
  final String description;
  final AddLocationRequest? location;
  final DateTime? scheduledDate;
  UuidValue? id;

  AddPostRequest({required this.images, required this.description, this.location, this.scheduledDate});

  Map<String, dynamic> toJson() {
    return {
      'images': images.map((image) => image.toJson()).toList(),
      'description': description,
      'location': location?.toJson(),
      'scheduledDate': scheduledDate?.toIso8601String(),
    };
  }

  FormData toFormData() {
    FormData formData = FormData();

    for (var image in images) {
      formData.files.add(MapEntry(
        'images[${image.position}].image',
        MultipartFile.fromFileSync(image.image.path, filename: image.image.path.split('/').last),
      ));
      formData.fields.add(MapEntry(
        'images[${image.position}].position',
        image.position.toString(),
      ));
    }

    formData.fields.add(MapEntry('description', description));
    if (location != null) {
      formData.fields.add(MapEntry('location.latitude', location!.latitude.toString()));
      formData.fields.add(MapEntry('location.longitude', location!.longitude.toString()));
      formData.fields.add(MapEntry('location.eventTime', location!.eventTime.toIso8601String()));
    }
    if(scheduledDate != null) {
      formData.fields.add(MapEntry('scheduledDate', scheduledDate!.toIso8601String()));
    }

    return formData;
  }
}
