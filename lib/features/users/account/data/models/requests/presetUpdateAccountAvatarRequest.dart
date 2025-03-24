import 'package:uuid/uuid.dart';

class PresetUpdateAccountAvatarRequest {
  final UuidValue imageGroupId;

  PresetUpdateAccountAvatarRequest({required this.imageGroupId});

  Map<String, dynamic> toJson() {
    return {
      'imageGroupId': imageGroupId,
    };
  }
}