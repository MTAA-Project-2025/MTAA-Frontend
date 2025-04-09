import 'package:hive/hive.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/crop_aspect_ratio_preset_custom_hive.dart';
import 'package:mtaa_frontend/features/posts/presentation/screens/add_post_screen.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/add_post_form.dart';


part 'add_image_hive.g.dart';

@HiveType(typeId: 7)
class AddImageHive extends HiveObject{
  @HiveField(0)
  String imagePath;

  @HiveField(1)
  int position;

  @HiveField(2)
  bool isAspectRatioError;

  @HiveField(3)
  CropAspectRatioPresetCustomHive? aspectRatioPreset=CropAspectRatioPresetCustomHive(width: 1, height: 1, name:'1x1');

  @HiveField(4)
  String origImagePath;

  AddImageHive({
    this.imagePath='',
    this.position=0,
    this.isAspectRatioError=false,
    this.aspectRatioPreset,
    this.origImagePath='',
  });

  factory AddImageHive.fromRequest(AddPostImageScreenDTO request, ImageDTO image){
    return AddImageHive(
      imagePath: '',
      position: request.position,
      isAspectRatioError: image.isAspectRatioError,
      aspectRatioPreset: CropAspectRatioPresetCustomHive.fromRequest(image.aspectRatioPreset),
      origImagePath: ''
    );
  }
}