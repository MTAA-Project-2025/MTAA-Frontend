import 'package:mtaa_frontend/features/users/versioning/data/VersionItem.dart';
import 'package:mtaa_frontend/features/users/versioning/shared/VersionItemTypes.dart';
import 'package:mtaa_frontend/features/users/versioning/storage/VersionItemsStorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VersionItemsStorageImpl implements VersionItemsStorage {
  final SharedPreferences prefs;

  VersionItemsStorageImpl(this.prefs);

  @override
  Future<void> saveVersionItem(VersionItem item) async {
    await prefs.setInt('${item.type.toString()}_version', item.version);
  }

  @override
  Future<int?> getVersionItem(VersionItemTypes type) async {
    return prefs.getInt('${type.toString()}_version');
  }

  @override
  Future<void> saveCurrentVersion(VersionItemTypes type, int version) async {
    await prefs.setInt('${type.toString()}_current_version', version);
  }

  @override
  Future<int?> getCurrentVersion(VersionItemTypes type) async {
    return prefs.getInt('${type.toString()}_current_version');
  }
}