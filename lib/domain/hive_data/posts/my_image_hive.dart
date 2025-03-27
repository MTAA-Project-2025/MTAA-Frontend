import 'package:hive/hive.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';


part 'my_image_hive.g.dart';

@HiveType(typeId: 0)
class MyImageHive extends HiveObject{

  @HiveField(0)
  String id;

  @HiveField(1)
  String shortPath;

  @HiveField(2)
  String fullPath;

  @HiveField(3)
  String localPath;

  @HiveField(4)
  String fileType;

  @HiveField(5)
  int height;

  @HiveField(6)
  int width;

  @HiveField(7)
  double aspectRatio;

  @HiveField(8)
  int type;

  MyImageHive({
    this.id='',
    this.shortPath='',
    this.fullPath='',
    this.fileType='',
    this.height=0,
    this.width=0,
    this.aspectRatio=0,
    this.type=0,
    this.localPath=''
  });

  factory MyImageHive.fromResponse(MyImageResponse response){
    return MyImageHive(
      id: response.id,
      shortPath: response.shortPath,
      fullPath: response.fullPath,
      fileType: response.fileType,
      height: response.height,
      width: response.width,
      aspectRatio: response.aspectRatio,
      type: response.type.index,
      localPath: response.localPath
    );
  }
}