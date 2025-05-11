import 'package:hive/hive.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/add_image_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/add_location_hive.dart';
import 'package:mtaa_frontend/features/posts/data/models/requests/add_post_request.dart';
import 'package:uuid/uuid.dart';


part 'add_post_hive.g.dart';

@HiveType(typeId: 5)
class AddPostHive extends HiveObject{

  @HiveField(0)
  AddLocationHive? location;
  
  @HiveField(1)
  String description;

  @HiveField(2)
  List<AddImageHive> images;

  @HiveField(3)
  DateTime? scheduledDate;

  @HiveField(4)
  String id;

  AddPostHive({
    this.location,
    this.description='',
    this.images=const [],
    this.scheduledDate,
    required this.id,
  });

  factory AddPostHive.fromRequest(AddPostRequest request, {DateTime? scheduledDate}){
    return AddPostHive(
      location: request.location!=null?AddLocationHive.fromRequest(request.location!):null,
      description: request.description,
      images: [],
      scheduledDate: scheduledDate,
      id: Uuid().v4(),
    );
  }
}
