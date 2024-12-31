import 'package:mtaa_frontend/core/config/env/env_config.dart';

class ProdConfig extends EnvConfig {
  @override
  String get baseUrl => 'https://test';

  @override
  bool get enableLogging => false;

  @override
  String get environment => 'production';
}