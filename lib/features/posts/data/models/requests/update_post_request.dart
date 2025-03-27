import 'package:dio/dio.dart';
import 'package:mtaa_frontend/features/images/data/models/requests/update_image_request.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/update_location_request.dart';
import 'package:uuid/uuid.dart';

class UpdatePostRequest {
  final UuidValue id;
  final List<UpdateImageRequest> images;
  final String description;
  final UpdateLocationRequest? location;

  UpdatePostRequest({required this.id, required this.images, required this.description, this.location});

  Map<String, dynamic> toJson() {
    return {
      'id': id.uuid,
      'images': images.map((image) => image.toJson()).toList(),
      'description': description,
      'location': location?.toJson(),
    };
  }

  FormData toFormData() {
    FormData formData = FormData();

    for (var image in images) {
      if (image.newImage != null) {
        formData.files.add(MapEntry(
          'images[${image.position}].newImage',
          MultipartFile.fromFileSync(image.newImage!.path, filename: image.newImage!.path.split('/').last),
        ));
      }
      if (image.oldImageId != null) {
        formData.fields.add(MapEntry(
          'images[${image.position}].oldImageId',
          image.oldImageId!,
        ));
      }
      formData.fields.add(MapEntry(
        'images[${image.position}].position',
        image.position.toString(),
      ));
    }
    formData.fields.add(MapEntry(
      'id',
      id.uuid,
    ));

    formData.fields.add(MapEntry('description', description));
    if (location != null) formData.fields.add(MapEntry('location', location.toString()));

    return formData;
  }
}
