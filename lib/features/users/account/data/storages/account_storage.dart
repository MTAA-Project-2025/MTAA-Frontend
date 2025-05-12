import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hive/hive.dart';
import 'package:mtaa_frontend/core/constants/storages/storage_boxes.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/userFullAccountResponse.dart';

abstract class AccountStorage {
  Future<UserFullAccountResponse?> getFullLocalAccount();
  Future setFullLocalAccount(UserFullAccountResponse account);
}

class AccountStorageImpl extends AccountStorage {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Future<UserFullAccountResponse?> getFullLocalAccount() async {
    var box = Hive.box(accountDataBox);
    await analytics.logEvent(name: 'get_full_local_account', parameters: {
      'box': accountDataBox,
      'key': "account",
    });
    return await box.get("account");
  }

  @override
  Future setFullLocalAccount(UserFullAccountResponse account) async {
    var box = Hive.box(accountDataBox);
    await analytics.logEvent(name: 'set_full_local_account', parameters: {
      'box': accountDataBox,
      'key': "account",
    });
    await box.put("account", account);
  }

}