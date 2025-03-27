import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/baseFullAccountResponse.dart';

class PublicFullAccountResponse extends BaseFullAccountResponse{
  final bool isFollowed;

  PublicFullAccountResponse({
    required super.id,
    super.avatar,
    required super.username,
    required super.displayName,
    required super.friendsCount,
    required super.followersCount,
    required this.isFollowed,
  });

  Map<String, dynamic> toJson() {
    return {  
      'id': id,    
      'avatar': avatar?.toJson(),
      'username': username,
      'displayName': displayName,
      'friendsCount': friendsCount,
      'followersCount': followersCount,
      'isFollowed': isFollowed,
    };
  }

  factory PublicFullAccountResponse.fromJson(Map<String, dynamic> json) {
    return PublicFullAccountResponse(
      id: json['id'],
      avatar: json['avatar'] != null
          ? MyImageGroupResponse.fromJson(json['avatar'])
          : null,
      username: json['username'],
      displayName: json['displayName'],
      friendsCount: json['friendsCount'],
      followersCount: json['followersCount'],
      isFollowed: json['isFollowed'],
    );
  }

}
