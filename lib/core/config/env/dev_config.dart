import 'package:mtaa_frontend/core/config/env/env_config.dart';

class DevConfig extends EnvConfig {
  @override
  String get baseUrl => 'https://10.0.2.2:7261/api/v1/';

  @override
  bool get enableLogging => true;

  @override
  String get environment => 'development';
}