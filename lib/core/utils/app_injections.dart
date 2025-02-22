import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mtaa_frontend/core/config/app_config.dart';
import 'package:mtaa_frontend/core/interceptors/auth-interceptor.dart';
import 'package:mtaa_frontend/features/images/data/network/preset_avatar_images_api.dart';
import 'package:mtaa_frontend/features/users/account/data/network/account_api.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/network/identity_api.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  Dio dio = Dio(BaseOptions(baseUrl: AppConfig.config.baseUrl));
  dio.interceptors.add(AuthInterceptor());

  getIt.registerSingleton<Dio>(
    dio
  );

  getIt.registerSingleton<IdentityApi>(
    IdentityImplApi(getIt<Dio>()),
  );
  getIt.registerSingleton<AccountApi>(
    AccountImplApi(getIt<Dio>()),
  );
  getIt.registerSingleton<PresetAvatarImagesApi>(
    PresetAvatarImagesApiImpl(getIt<Dio>()),
  );
}