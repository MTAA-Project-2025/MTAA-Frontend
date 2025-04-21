import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mtaa_frontend/core/config/app_config.dart';
import 'package:mtaa_frontend/core/interceptors/auth-interceptor.dart';
import 'package:mtaa_frontend/core/interceptors/error_interceptor.dart';
import 'package:mtaa_frontend/core/services/exceptions_service.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/core/services/number_formating_service.dart';
import 'package:mtaa_frontend/core/services/time_formating_service.dart';
import 'package:mtaa_frontend/domain/entities/my_db_context.dart';
import 'package:mtaa_frontend/features/images/data/network/preset_avatar_images_api.dart';
import 'package:mtaa_frontend/features/images/data/storages/my_image_storage.dart';
import 'package:mtaa_frontend/features/locations/data/network/locations_api.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/locations/data/storages/locations_storage.dart';
import 'package:mtaa_frontend/features/posts/data/network/posts_api.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/data/storages/posts_storage.dart';
import 'package:mtaa_frontend/features/users/account/data/network/account_api.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/network/identity_api.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  Dio dio = Dio(BaseOptions(baseUrl: AppConfig.config.baseUrl));
  dio.interceptors.add(AuthInterceptor());
  dio.interceptors.add(ErrorInterceptor());

  getIt.registerSingleton<Dio>(dio);

  getIt.registerSingleton<MyToastService>(
    MyToastServiceImpl(),
  );
  getIt.registerSingleton<MyImageStorage>(
    MyImageStorageImpl(),
  );

  getIt.registerSingleton<MyDbContext>(
    MyDbContext(),
  );

  getIt.registerSingleton<TimeFormatingService>(
    TimeFormatingServiceImpl(),
  );
  getIt.registerSingleton<NumberFormatingService>(
    NumberFormatingServiceImpl(),
  );
  getIt.registerSingleton<ExceptionsService>(
    ExceptionsServiceImpl(getIt<MyToastService>()),
  );
  getIt.registerSingleton<PresetAvatarImagesApi>(
    PresetAvatarImagesApiImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<IdentityApi>(
    IdentityImplApi(getIt<Dio>()),
  );

  getIt.registerSingleton<LocationsApi>(
    LocationsApiImpl(getIt<Dio>(), getIt<ExceptionsService>()),
  );

  getIt.registerSingleton<PostsApi>(
    PostsApiImpl(getIt<Dio>(), getIt<ExceptionsService>()),
  );
  getIt.registerSingleton<PostsStorage>(
    PostsStorageImpl(getIt<MyDbContext>(), getIt<MyImageStorage>(), getIt<Dio>()),
  );
  getIt.registerSingleton<PostsRepository>(
    PostsRepositoryImpl(getIt<PostsApi>(), getIt<PostsStorage>()),
  );

  getIt.registerSingleton<LocationsStorage>(
    LocationsStorageImpl(),
  );
  getIt.registerSingleton<LocationsRepository>(
    LocationsRepositoryImpl(getIt<LocationsApi>(), getIt<PostsStorage>(),getIt<LocationsStorage>()),
  );

  getIt.registerSingleton<AccountApi>(
    AccountApiImpl(getIt<Dio>(), getIt<ExceptionsService>()),
  );
  getIt.registerSingleton<AccountRepository>(
    AccountRepositoryImpl(getIt<AccountApi>()),
  );
}
