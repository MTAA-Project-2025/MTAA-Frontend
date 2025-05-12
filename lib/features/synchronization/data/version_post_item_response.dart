import 'package:uuid/uuid.dart';

class VersionPostItemResponse {
  final UuidValue id;
  final int version;

  VersionPostItemResponse({
    required this.id,
    required this.version,
  });

  factory VersionPostItemResponse.fromJson(Map<String, dynamic> json) {
    return VersionPostItemResponse(
      id: UuidValue.fromString(json['id']),
      version: json['version'],
    );
  }
}
