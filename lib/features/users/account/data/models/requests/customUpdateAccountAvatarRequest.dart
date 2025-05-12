import 'dart:convert';
import 'dart:io';

class CustomUpdateAccountAvatarRequest {
  final File avatar;

  CustomUpdateAccountAvatarRequest({required this.avatar});

  Map<String, dynamic> toJson() {
    final bytes = avatar.readAsBytesSync();
    final base64Avatar = base64Encode(bytes);

    return {
      'avatar': base64Avatar,
    };
  }
}
