import 'package:mtaa_frontend/features/users/versioning/data/VersionItem.dart';
import 'package:mtaa_frontend/features/users/versioning/shared/VersionItemTypes.dart';

abstract class VersionItemsStorage {
  Future<void> saveVersionItem(VersionItem item);
  Future<int?> getVersionItem(VersionItemTypes type);
  Future<void> saveCurrentVersion(VersionItemTypes type, int version);
  Future<int?> getCurrentVersion(VersionItemTypes type);
}