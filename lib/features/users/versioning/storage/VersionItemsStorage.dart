import 'package:mtaa_frontend/features/users/versioning/data/VersionItem.dart';
import 'package:mtaa_frontend/features/users/versioning/shared/VersionItemTypes.dart';

abstract class VersionItemsStorage {
  Future saveVersionItem(VersionItem item);
  Future<int> getVersionItem(VersionItemTypes type);
}