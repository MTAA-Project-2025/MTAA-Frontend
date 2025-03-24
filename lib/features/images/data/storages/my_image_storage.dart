import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';

abstract class MyImageStorage {
  Future<String> saveTempImage(Uint8List data, String name);
  Future deleteImage(String path);
}

class MyImageStorageImpl extends MyImageStorage {
  @override
  Future<String> saveTempImage(Uint8List data, String name) async {
    final tempDir = await getApplicationDocumentsDirectory();
    final imageFile = File('${tempDir.path}/$name.jpg');
    await imageFile.writeAsBytes(data);

    return imageFile.path;
  }

  @override
  Future deleteImage(String path) async {
    File file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
