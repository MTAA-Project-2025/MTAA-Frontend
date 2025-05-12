import 'package:mtaa_frontend/features/users/versioning/data/VersionItem.dart';

abstract class VersionItemsApi {
  Future<List<VersionItem>> getVersionItems();
}