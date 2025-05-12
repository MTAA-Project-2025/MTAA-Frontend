import 'dart:io';

import 'package:drift/drift.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

abstract class MyImageStorage {
  Future<String> saveTempImage(Uint8List data, String name);
  Future<String> saveStortLifeTempImage(Uint8List data, String name);
  Future<Uint8List?> urlToUint8List(String imageUrl);
  Future deleteImage(String path);
}

class MyImageStorageImpl extends MyImageStorage {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  Future<String> saveTempImage(Uint8List data, String name) async {
    final tempDir = await getApplicationDocumentsDirectory();
    String id = Uuid().v4();
    final imageFile = File('${tempDir.path}/${name}_$id.jpg');
    await imageFile.writeAsBytes(data);

    return imageFile.path;
  }

  @override
  Future<String> saveStortLifeTempImage(Uint8List data, String name) async {
    final tempDir = await getTemporaryDirectory();
    String id = Uuid().v4();
    final imageFile = File('${tempDir.path}/${name}_$id.jpg');
    await imageFile.writeAsBytes(data);

    return imageFile.path;
  }


  @override
  Future deleteImage(String path) async {
    File file = File(path);
    await analytics.logEvent(name: 'delete_image', parameters: {
      'path': path,
    });
    if (await file.exists()) {
      await file.delete();
    }
  }

  //Gpt
  @override
  Future<Uint8List?> urlToUint8List(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print('Failed to load image: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
