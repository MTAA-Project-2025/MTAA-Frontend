import 'package:mtaa_frontend/core/config/env/dev_config.dart';
import 'package:mtaa_frontend/core/config/env/env_config.dart';
import 'package:mtaa_frontend/core/config/env/prod_config.dart';

class AppConfig {
  static late EnvConfig _config;

  static void loadConfig(String environment) {
    if (environment == 'production') {
      _config = ProdConfig();
    } else {
      _config = DevConfig();
    }
  }

  static EnvConfig get config => _config;
}