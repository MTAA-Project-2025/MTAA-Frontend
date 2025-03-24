import 'package:mtaa_frontend/domain/hive_data/posts/simple_user_hive.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';

class PublicSimpleAccountResponse {
  final String id;
  final String username;
  final String displayName;
  final bool isFollowed;
  final MyImageGroupResponse? avatar;

  PublicSimpleAccountResponse({
    required this.id,
    required this.username,
    required this.displayName,
    required this.isFollowed,
    this.avatar,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'displayName': displayName,
      'isFollowed': isFollowed,
      'avatar': avatar?.toJson(),
    };
  }

  factory PublicSimpleAccountResponse.fromJson(Map<String, dynamic> json) {
    return PublicSimpleAccountResponse(
      id: json['id'],
      username: json['username'],
      displayName: json['displayName'],
      isFollowed: json['isFollowed'],
      avatar: json['avatar'] != null
          ? MyImageGroupResponse.fromJson(json['avatar'])
          : null,
    );
  }

  factory PublicSimpleAccountResponse.fromHive(SimpleUserHive hive){
    return PublicSimpleAccountResponse(
      id: hive.id,
      username: hive.username,
      displayName: hive.displayName,
      isFollowed: false,
      avatar: hive.avatar != null
          ? MyImageGroupResponse.fromHive(hive.avatar!)
          : null,
    );
  }
}
