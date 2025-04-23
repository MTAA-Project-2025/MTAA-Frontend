import 'package:hive/hive.dart';
import 'package:mtaa_frontend/domain/hive_data/posts/my_image_hive.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/simple_location_point_response.dart';


part 'simple_point_hive.g.dart';

@HiveType(typeId: 9)
class SimplePointHive extends HiveObject{

  @HiveField(0)
  String id;

  @HiveField(1)
  String? postId;

  @HiveField(2)
  double longitude;

  @HiveField(3)
  double latitude;

  @HiveField(4)
  int type;

  @HiveField(5)
  int zoomLevel;

  @HiveField(6)
  int childCount;

  @HiveField(7)
  MyImageHive? image;

  SimplePointHive({
    this.id='',
    this.postId,
    this.longitude = -200,
    this.latitude = -200,
    this.type = 0,
    this.zoomLevel = 0,
    this.childCount = 0,
    this.image,
  });

  factory SimplePointHive.fromResponse(SimpleLocationPointResponse request){
    return SimplePointHive(
        id: request.id.uuid,
        postId: request.postId?.uuid,
        longitude: request.longitude,
        latitude: request.latitude,
        type: request.type.index,
        zoomLevel: request.zoomLevel,
        childCount: request.childCount,
        image: request.image==null?null:MyImageHive.fromResponse(request.image!),
    );
  }
}