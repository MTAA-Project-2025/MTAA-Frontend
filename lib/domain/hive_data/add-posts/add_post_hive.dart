import 'package:hive/hive.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/add_image_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/add_location_hive.dart';
import 'package:mtaa_frontend/features/posts/data/models/requests/add_post_request.dart';


part 'add_post_hive.g.dart';

@HiveType(typeId: 5)
class AddPostHive extends HiveObject{

  @HiveField(0)
  AddLocationHive? location;
  
  @HiveField(1)
  String description;

  @HiveField(2)
  List<AddImageHive> images;

  AddPostHive({
    this.location,
    this.description='',
    this.images=const [],
  });

  factory AddPostHive.fromRequest(AddPostRequest request){
    return AddPostHive(
      location: request.location!=null?AddLocationHive.fromRequest(request.location!):null,
      description: request.description,
      images: [],
    );
  }
}
