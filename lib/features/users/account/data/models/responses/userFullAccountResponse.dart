import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicFullAccountResponse.dart';

class UserFullAccountResponse extends PublicFullAccountResponse {
  final DateTime? birthDate;
  final String? email;
  final String? phoneNumber;
  final int likesCount;

  UserFullAccountResponse({
    required super.id,
    super.avatar,
    required super.username,
    required super.displayName,
    required super.isFollowing,
    required super.dataCreationTime,
    required super.friendsCount,
    required super.followersCount,
    this.birthDate,
    this.email,
    this.phoneNumber,
    required this.likesCount,
  });

  @override
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
      'birthDate': birthDate?.toIso8601String(),
      'email': email,
      'phoneNumber': phoneNumber,
      'likesCount': likesCount,
    };
  }

  factory UserFullAccountResponse.fromJson(Map<String, dynamic> json) {
    return UserFullAccountResponse(
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
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate'])
          : null,
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      likesCount: json['likesCount'],
    );
  }
}
