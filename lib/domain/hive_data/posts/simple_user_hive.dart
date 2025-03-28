import 'package:hive/hive.dart';
import 'package:mtaa_frontend/domain/hive_data/posts/my_image_group_hive.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';

part 'simple_user_hive.g.dart';

@HiveType(typeId: 3)
class SimpleUserHive extends HiveObject{

  @HiveField(0)
  final String id;

  @HiveField(1)
  String username;

  @HiveField(2)
  String displayName;

  @HiveField(3)
  MyImageGroupHive? avatar;

  SimpleUserHive({
    required this.id,
    this.username='',
    this.displayName='',
    this.avatar,
  });

  factory SimpleUserHive.fromResponse(PublicBaseAccountResponse response){
    return SimpleUserHive(
      id: response.id,
      username: response.username,
      displayName: response.displayName,
      avatar: response.avatar != null
          ? MyImageGroupHive.fromResponse(response.avatar!)
          : null,
    );
  }
}
