import 'package:mtaa_frontend/domain/hive_data/posts/simple_user_hive.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';

class PublicBaseAccountResponse {
  final String id;
  final MyImageGroupResponse? avatar;
  final String username;
  final String displayName;
  bool isFollowing;
  

  PublicBaseAccountResponse({
    required this.id,
    this.avatar,
    required this.username,
    required this.displayName,
    required this.isFollowing
  });

  Map<String, dynamic> toJson() {
    return {  
      'id': id,    
      'avatar': avatar?.toJson(),
      'username': username,
      'displayName': displayName,
      'isFollowing': isFollowing,
    };
  }

  factory PublicBaseAccountResponse.fromJson(Map<String, dynamic> json) {
    return PublicBaseAccountResponse(
      id: json['id'],
      avatar: json['avatar'] != null
          ? MyImageGroupResponse.fromJson(json['avatar'])
          : null,
      username: json['username'],
      displayName: json['displayName'],
      isFollowing: json['isFollowing'],
    );
  }

  factory PublicBaseAccountResponse.fromHive(SimpleUserHive hive){
    return PublicBaseAccountResponse(
      id: hive.id,
      username: hive.username,
      displayName: hive.displayName,
      isFollowing: false,
      avatar: hive.avatar != null
          ? MyImageGroupResponse.fromHive(hive.avatar!)
          : null,
    );
  }
}
