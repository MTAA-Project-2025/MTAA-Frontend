import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hive/hive.dart';
import 'package:mtaa_frontend/core/constants/storages/storage_boxes.dart';
import 'package:mtaa_frontend/features/users/versioning/data/VersionItem.dart';
import 'package:mtaa_frontend/features/users/versioning/shared/VersionItemTypes.dart';
import 'package:mtaa_frontend/features/users/versioning/storage/VersionItemsStorage.dart';

class VersionItemsStorageImpl implements VersionItemsStorage {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  Future saveVersionItem(VersionItem item) async {
    var box = Hive.box(currentUserDataBox);
    await analytics.logEvent(name: 'save_version_item', parameters: {
      'box': currentUserDataBox,
      'key': "version_${item.type.index}",
      'type': item.type.toString(),
      'version': item.version,
    });
    await box.put("version_${item.type.index}", item.version);
  }
  
  @override
  Future<int> getVersionItem(VersionItemTypes type) async {
    var box = Hive.box(currentUserDataBox);
    var data = box.get("version_${type.index}");

    await analytics.logEvent(name: 'get_version_item', parameters: {
      'box': currentUserDataBox,
      'key': "version_${type.index}",
      'type': type.toString(),
    });
    if(data==null)return 0;
    return  data as int;
  }
}