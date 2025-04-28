import 'package:hive/hive.dart';
import 'package:mtaa_frontend/core/constants/storages/storage_boxes.dart';
import 'package:mtaa_frontend/features/users/versioning/data/VersionItem.dart';
import 'package:mtaa_frontend/features/users/versioning/shared/VersionItemTypes.dart';
import 'package:mtaa_frontend/features/users/versioning/storage/VersionItemsStorage.dart';

class VersionItemsStorageImpl implements VersionItemsStorage {
  
  @override
  Future saveVersionItem(VersionItem item) async {
    var box = Hive.box(currentUserDataBox);
    await box.put("version_${item.type.index}", item.version);
  }
  
  @override
  Future<int> getVersionItem(VersionItemTypes type) async {
    var box = Hive.box(currentUserDataBox);
    var data = box.get("version_${type.index}");
    if(data==null)return 0;
    return  data as int;
  }
}