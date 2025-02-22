import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';

class PublicFullAccountResponse {
  final String id;
  final String username;
  final String displayName;
  final DateTime birthDate;
  final String status;
  final DateTime lastSeen;
  final DateTime dataCreationTime;
  final bool isContact;
  final bool isBlocked;
  final MyImageGroupResponse? avatar;

  PublicFullAccountResponse({
    required this.id,
    required this.username,
    required this.displayName,
    required this.birthDate,
    required this.status,
    required this.lastSeen,
    required this.dataCreationTime,
    required this.isContact,
    required this.isBlocked,
    this.avatar,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'displayName': displayName,
      'birthDate': birthDate.toIso8601String(),
      'status': status,
      'lastSeen': lastSeen.toIso8601String(),
      'dataCreationTime': dataCreationTime.toIso8601String(),
      'isContact': isContact,
      'isBlocked': isBlocked,
      'avatar': avatar?.toJson(),
    };
  }

  factory PublicFullAccountResponse.fromJson(Map<String, dynamic> json) {
    return PublicFullAccountResponse(
      id: json['id'],
      username: json['username'],
      displayName: json['displayName'],
      birthDate: DateTime.parse(json['birthDate']),
      status: json['status'],
      lastSeen: DateTime.parse(json['lastSeen']),
      dataCreationTime: DateTime.parse(json['dataCreationTime']),
      isContact: json['isContact'],
      isBlocked: json['isBlocked'],
      avatar: json['avatar'] != null
          ? MyImageGroupResponse.fromJson(json['avatar'])
          : null,
    );
  }
}
