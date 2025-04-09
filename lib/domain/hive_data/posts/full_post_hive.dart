import 'package:hive/hive.dart';
import 'package:mtaa_frontend/domain/hive_data/posts/my_image_group_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/posts/simple_user_hive.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';


part 'full_post_hive.g.dart';

@HiveType(typeId: 2)
class FullPostHive extends HiveObject{

  @HiveField(0)
  String id;
  
  @HiveField(1)
  String description;

  @HiveField(2)
  List<MyImageGroupHive> images;

  @HiveField(3)
  SimpleUserHive owner;

  @HiveField(4)
  int likesCount;

  @HiveField(5)
  int commentsCount;
  
  @HiveField(6)
  bool isLiked;

  @HiveField(7)
  String? locationId;

  @HiveField(8)
  DateTime dataCreationTime;

  @HiveField(9)
  bool isLocal;

  FullPostHive({
    required this.id,
    this.description='',
    this.images=const [],
    required this.owner,
    this.likesCount=0,
    this.commentsCount=0,
    this.isLiked=false,
    this.locationId,
    DateTime? dataCreationTime,
    this.isLocal = false,
  }) : dataCreationTime = dataCreationTime ?? DateTime.now();

  factory FullPostHive.fromResponse(FullPostResponse response){
    return FullPostHive(
      id: response.id.uuid,
      description: response.description,
      images: response.images.map((image) => MyImageGroupHive.fromResponse(image)).toList(),
      owner: SimpleUserHive.fromResponse(response.owner),
      likesCount: response.likesCount,
      commentsCount: response.commentsCount,
      isLiked: response.isLiked,
      locationId: response.locationId?.uuid,
      dataCreationTime: response.dataCreationTime,
    );
  }
}
