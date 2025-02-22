class PresetUpdateAccountAvatarRequest {
  final String imageGroupId;

  PresetUpdateAccountAvatarRequest({required this.imageGroupId});

  Map<String, dynamic> toJson() {
    return {
      'imageGroupId': imageGroupId,
    };
  }
}