
import 'package:hive/hive.dart';
import 'package:mtaa_frontend/features/images/domain/utils/cropAspectRatioPresetCustom.dart';


part 'crop_aspect_ratio_preset_custom_hive.g.dart';

@HiveType(typeId: 8)
class CropAspectRatioPresetCustomHive extends HiveObject{
  @HiveField(0)
  int width;

  @HiveField(1)
  int height;

  @HiveField(2)
  String name;

  CropAspectRatioPresetCustomHive({this.width=0,
  this.height=0,
  this.name=''});

  factory CropAspectRatioPresetCustomHive.fromRequest(CropAspectRatioPresetCustom request){
    return CropAspectRatioPresetCustomHive(
      width: request.width,
      height: request.height,
      name: request.name
    );
  }
}
