import 'package:hive/hive.dart';
import 'package:mtaa_frontend/core/constants/storages/storage_boxes.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/userFullAccountResponse.dart';

abstract class AccountStorage {
  Future<UserFullAccountResponse?> getFullLocalAccount();
  Future setFullLocalAccount(UserFullAccountResponse account);
}

class AccountStorageImpl extends AccountStorage {

  @override
  Future<UserFullAccountResponse?> getFullLocalAccount() async {
    var box = Hive.box(accountDataBox);
    return await box.get("account");
  }

  @override
  Future setFullLocalAccount(UserFullAccountResponse account) async {
    var box = Hive.box(accountDataBox);
    await box.put("account", account);
  }

}