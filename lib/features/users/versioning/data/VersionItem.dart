import 'package:mtaa_frontend/features/users/versioning/shared/VersionItemTypes.dart';

class VersionItem {
  final VersionItemTypes type;
  final int version;

  VersionItem({required this.type, required this.version});

  factory VersionItem.fromJson(Map<String, dynamic> json) {
    return VersionItem(
      type: VersionItemTypes.values[json['type']],
      version: json['version'],
    );
  }
}