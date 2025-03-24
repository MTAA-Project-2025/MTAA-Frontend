import 'package:mtaa_frontend/features/users/versioning/api/VersionItemsApi.dart';
import 'package:mtaa_frontend/features/users/versioning/storage/VersionItemsStorage.dart';

class VersionItemsService {
  final VersionItemsApi versionItemsApi;
  final VersionItemsStorage versionItemsStorage;

  VersionItemsService(this.versionItemsApi, this.versionItemsStorage);

  Future<void> syncVersionItems() async {
    final remoteVersionItems = await versionItemsApi.getVersionItems();

    for (var item in remoteVersionItems) {
      final currentVersion = await versionItemsStorage.getCurrentVersion(item.type);

      if (currentVersion != item.version) {
        await versionItemsStorage.saveVersionItem(item);
        await versionItemsStorage.saveCurrentVersion(item.type, item.version);
        print("Updated version for ${item.type}");
      } else {
        print("Version for ${item.type} is already up to date.");
      }
    }
  }
}