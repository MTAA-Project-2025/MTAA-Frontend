import 'package:mtaa_frontend/features/users/versioning/api/VersionItemsApi.dart';
import 'package:mtaa_frontend/features/users/versioning/data/VersionItem.dart';
import 'package:mtaa_frontend/features/users/versioning/shared/VersionItemTypes.dart';

class VersionItemsApiImpl implements VersionItemsApi {
  @override
  Future<List<VersionItem>> getVersionItems() async {
    return [
      VersionItem(type: VersionItemTypes.Account, version: 1),
      VersionItem(type: VersionItemTypes.Settings, version: 1),
    ];
  }
}