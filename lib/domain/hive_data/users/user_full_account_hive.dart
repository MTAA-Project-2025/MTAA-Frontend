import 'package:hive/hive.dart';
import 'package:mtaa_frontend/domain/hive_data/posts/my_image_group_hive.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/userFullAccountResponse.dart';

part 'user_full_account_hive.g.dart';

@HiveType(typeId: 12)
class UserFullAccountHive  extends HiveObject{

  @HiveField(0)
  DateTime? birthDate;

  @HiveField(1)
  String? email;

  @HiveField(2)
  String? phoneNumber;

  @HiveField(3)
  int likesCount;

  @HiveField(4)
  DateTime dataCreationTime;

  @HiveField(5)
  int followersCount;
  
  @HiveField(6)
  int friendsCount;

  @HiveField(7)
  String id;

  @HiveField(8)
  MyImageGroupHive? avatar;

  @HiveField(9)
  String username;

  @HiveField(10)
  String displayName;

  @HiveField(11)
  bool isFollowing;

  UserFullAccountHive({
    required this.id,
    this.avatar,
    required this.username,
    required this.displayName,
    required this.isFollowing,
    required this.dataCreationTime,
    required this.friendsCount,
    required this.followersCount,
    this.birthDate,
    this.email,
    this.phoneNumber,
    required this.likesCount,
  });

  factory UserFullAccountHive.fromResponse(UserFullAccountResponse response) {
    return UserFullAccountHive(
      id: response.id,
      avatar: response.avatar != null
          ? MyImageGroupHive.fromResponse(response.avatar!)
          : null,
      username: response.username,
      displayName: response.displayName,
      isFollowing: response.isFollowing,
      dataCreationTime: response.dataCreationTime,
      friendsCount: response.friendsCount,
      followersCount: response.followersCount,
      birthDate: response.birthDate,
      email: response.email,
      phoneNumber: response.phoneNumber,
      likesCount: response.likesCount,
    );
  }
}
