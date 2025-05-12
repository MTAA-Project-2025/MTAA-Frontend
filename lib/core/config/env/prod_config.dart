import 'package:mtaa_frontend/core/config/env/env_config.dart';

class ProdConfig extends EnvConfig {
  @override
  String get baseUrl => 'https://10.10.28.170:7261/api/v1/';

  @override
  bool get enableLogging => false;

  @override
  String get environment => 'production';
}