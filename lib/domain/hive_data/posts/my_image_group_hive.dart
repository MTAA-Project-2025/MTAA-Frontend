import 'package:hive/hive.dart';
import 'package:mtaa_frontend/domain/hive_data/posts/my_image_hive.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';


part 'my_image_group_hive.g.dart';

@HiveType(typeId: 1)
class MyImageGroupHive extends HiveObject{

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  int position;

  @HiveField(3)
  List<MyImageHive> images;

  MyImageGroupHive({
    required this.id,
    this.title='',
    this.position=0,
    this.images = const [],
  });

  factory MyImageGroupHive.fromResponse(MyImageGroupResponse response){
    return MyImageGroupHive(
      id: response.id.uuid,
      title: response.title,
      position: response.position,
      images: response.images.map((image) => MyImageHive.fromResponse(image)).toList(),
    );
  }
}
