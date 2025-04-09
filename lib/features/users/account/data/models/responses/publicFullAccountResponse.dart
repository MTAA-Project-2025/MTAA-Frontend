import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';

class PublicFullAccountResponse extends PublicBaseAccountResponse{
  final DateTime dataCreationTime;
  int followersCount;
  int friendsCount;

  PublicFullAccountResponse({
    required super.id,
    super.avatar,
    required super.username,
    required super.displayName,
    required super.isFollowing,
    required this.dataCreationTime,
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
      'isFollowing': isFollowing,
      'dataCreationTime': dataCreationTime.toIso8601String(),
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
      isFollowing: json['isFollowing'],
      dataCreationTime: DateTime.parse(json['dataCreationTime']),
    );
  }

}
