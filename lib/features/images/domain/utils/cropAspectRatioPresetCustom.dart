import 'package:image_cropper/image_cropper.dart';

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  int width;
  int height;
  String _name;

  CropAspectRatioPresetCustom(this.width, this.height, this._name);

  @override
  (int, int)? get data => (width, height);

  set data((int, int)? value) {
    if (value != null) {
      width = value.$1;
      height = value.$2;
    }
  }

  @override
  String get name => _name;
}