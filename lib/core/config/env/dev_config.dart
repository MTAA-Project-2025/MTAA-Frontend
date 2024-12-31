import 'package:mtaa_frontend/core/config/env/env_config.dart';

class DevConfig extends EnvConfig {
  @override
  String get baseUrl => 'https://test';

  @override
  bool get enableLogging => true;

  @override
  String get environment => 'development';
}