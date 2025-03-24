import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';

class BaseFullAccountResponse {
  final String id;
  final MyImageGroupResponse? avatar;
  final String username;
  final String displayName;
  final int friendsCount;
  final int followersCount;
  

  BaseFullAccountResponse({
    required this.id,
    this.avatar,
    required this.username,
    required this.displayName,
    required this.friendsCount,
    required this.followersCount,
  });

  Map<String, dynamic> toJson() {
    return {  
      'id': id,    
      'avatar': avatar?.toJson(),
      'username': username,
      'displayName': displayName,
      'friendsCount': friendsCount,
      'followersCount': followersCount,
    };
  }

  factory BaseFullAccountResponse.fromJson(Map<String, dynamic> json) {
    return BaseFullAccountResponse(
      id: json['id'],
      avatar: json['avatar'] != null
          ? MyImageGroupResponse.fromJson(json['avatar'])
          : null,
      username: json['username'],
      displayName: json['displayName'],
      friendsCount: json['friendsCount'],
      followersCount: json['followersCount'],
    );
  }
}
