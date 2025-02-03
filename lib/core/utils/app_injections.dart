import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mtaa_frontend/core/config/app_config.dart';
import 'package:mtaa_frontend/features/authentication/data/network/identity_api.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: AppConfig.config.baseUrl)),
  );

  // Register Identity API using the Dio instance
  getIt.registerSingleton<IdentityApi>(
    IdentityImplApi(getIt<Dio>()),
  );
}