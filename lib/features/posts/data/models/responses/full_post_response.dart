import 'package:mtaa_frontend/domain/hive_data/posts/full_post_hive.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';
import 'package:uuid/uuid.dart';

class FullPostResponse {
  final UuidValue id;
  final String description;
  final List<MyImageGroupResponse> images;

  final PublicBaseAccountResponse owner;

  int likesCount;
  int commentsCount;
  bool isLiked;

  final UuidValue? locationId;

  final DateTime dataCreationTime;

  bool isLocal;

  bool isSaved=false;
  bool isHidden;

  FullPostResponse({
    required this.id,
    required this.description,
    required this.images,
    required this.owner,
    required this.likesCount,
    required this.commentsCount,
    required this.isLiked,
    this.locationId,
    required this.dataCreationTime,
    this.isLocal = false,
    this.isHidden = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id.uuid,
      'description': description,
      'images': images.map((image) => image.toJson()).toList(),
      'owner': owner.toJson(),
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'isLiked': isLiked,
      'locationId': locationId?.uuid,
      'dataCreationTime': dataCreationTime.toIso8601String(),
      'isHidden': isHidden,
    };
  }
  factory FullPostResponse.fromJson(Map<String, dynamic> json) {
    return FullPostResponse(
      id: UuidValue.fromString(json['id']),
      description: json['description'],
      owner: PublicBaseAccountResponse.fromJson(json['owner']),
      likesCount: json['likesCount'],
      commentsCount: json['commentsCount'],
      isLiked: json['isLiked'],
      locationId: json['locationId']==null?null:UuidValue.fromString(json['locationId']),
      dataCreationTime: DateTime.parse(json['dataCreationTime']),
      images: (json['images'] as List)
          .map((image) => MyImageGroupResponse.fromJson(image))
          .toList(),
      isHidden: json['isHidden'] ?? false,
    );
  }

  
  factory FullPostResponse.fromHive(FullPostHive hive){
    return FullPostResponse(
      id: UuidValue.fromString(hive.id),
      description: hive.description,
      images: hive.images.map((image) => MyImageGroupResponse.fromHive(image)).toList(),
      owner: PublicBaseAccountResponse.fromHive(hive.owner),
      likesCount: hive.likesCount,
      commentsCount: hive.commentsCount,
      isLiked: hive.isLiked,
      locationId: hive.locationId!=null?UuidValue.fromString(hive.locationId!):null,
      dataCreationTime: hive.dataCreationTime,
      isLocal:true,
    );
  }
}
