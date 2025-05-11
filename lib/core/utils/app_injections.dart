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
import 'package:mtaa_frontend/features/comments/data/networks/comments_api.dart';
import 'package:mtaa_frontend/features/comments/data/repositories/comments_repository.dart';
import 'package:mtaa_frontend/features/images/data/network/preset_avatar_images_api.dart';
import 'package:mtaa_frontend/features/images/data/storages/my_image_storage.dart';
import 'package:mtaa_frontend/features/locations/data/network/locations_api.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/locations/data/storages/locations_storage.dart';
import 'package:mtaa_frontend/features/notifications/data/network/notificationsApi.dart';
import 'package:mtaa_frontend/features/notifications/data/network/notificationsService.dart';
import 'package:mtaa_frontend/features/notifications/data/network/phoneNotificationService.dart';
import 'package:mtaa_frontend/features/notifications/data/repositories/notificationsRepository.dart';
import 'package:mtaa_frontend/features/posts/data/network/posts_api.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/data/storages/posts_storage.dart';
import 'package:mtaa_frontend/features/synchronization/synchronization_service.dart';
import 'package:mtaa_frontend/features/users/account/data/network/account_api.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/account/data/storages/account_storage.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/network/identity_api.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';
import 'package:mtaa_frontend/features/users/versioning/api/VersionItemsApi.dart';
import 'package:mtaa_frontend/features/users/versioning/api/VersionItemsApiImpl.dart';
import 'package:mtaa_frontend/features/users/versioning/storage/VersionItemsStorage.dart';
import 'package:mtaa_frontend/features/users/versioning/storage/VersionItemsStorageImpl.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {

  getIt.registerSingleton<TokenStorage>(
    TokenStorage(),
  );

  Dio dio = Dio(BaseOptions(baseUrl: AppConfig.config.baseUrl));
  dio.interceptors.add(AuthInterceptor(getIt<TokenStorage>()));
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
    IdentityImplApi(getIt<Dio>(), getIt<ExceptionsService>()),
  );

  getIt.registerSingleton<LocationsApi>(
    LocationsApiImpl(getIt<Dio>(), getIt<ExceptionsService>()),
  );

  getIt.registerSingleton<PostsApi>(
    PostsApiImpl(getIt<Dio>(), getIt<ExceptionsService>()),
  );

  getIt.registerSingleton<PhoneNotificationsService>(
    PhoneNotificationsServiceImpl(),
  );

  getIt.registerSingleton<PostsStorage>(
    PostsStorageImpl(getIt<MyDbContext>(),
    getIt<MyImageStorage>(),
    getIt<Dio>(),
    getIt<PhoneNotificationsService>(),
    getIt<TokenStorage>()),
  );
  getIt.registerSingleton<PostsRepository>(
    PostsRepositoryImpl(getIt<PostsApi>(), getIt<PostsStorage>(), getIt<TokenStorage>()),
  );

  getIt.registerSingleton<LocationsStorage>(
    LocationsStorageImpl(),
  );
  getIt.registerSingleton<LocationsRepository>(
    LocationsRepositoryImpl(getIt<LocationsApi>(),
    getIt<PostsStorage>(),
    getIt<LocationsStorage>()),
  );

  getIt.registerSingleton<AccountApi>(
    AccountApiImpl(getIt<Dio>(), getIt<ExceptionsService>()),
  );
  getIt.registerSingleton<AccountStorage>(
    AccountStorageImpl()
  );

  getIt.registerSingleton<AccountRepository>(
    AccountRepositoryImpl(getIt<AccountApi>(), getIt<AccountStorage>()),
  );
  
  getIt.registerSingleton<NotificationsApi>(
    NotificationsApiImpl(getIt<Dio>(), getIt<ExceptionsService>()),
  );
  getIt.registerSingleton<NotificationsRepository>(
    NotificationsRepositoryImpl(getIt<NotificationsApi>()),
  );

  getIt.registerSingleton<VersionItemsApi>(
    VersionItemsApiImpl(getIt<Dio>(), getIt<ExceptionsService>()),
  );

  getIt.registerSingleton<VersionItemsStorage>(
    VersionItemsStorageImpl(),
  );

  getIt.registerSingleton<SynchronizationService>(
    SynchronizationServiceImpl(getIt<PostsApi>(),
        getIt<LocationsApi>(),
        getIt<PostsStorage>(),
        getIt<VersionItemsApi>(),
        getIt<VersionItemsStorage>(),
        getIt<AccountApi>())
  );

  getIt.registerSingleton<NotificationsService>(
  NotificationsServiceImpl(getIt<MyToastService>(),
        getIt<SynchronizationService>()),
  );
  getIt.registerSingleton<CommentsApi>(
    CommentsApiImpl(getIt<Dio>(), getIt<ExceptionsService>()),
  );
  getIt.registerSingleton<CommentsRepository>(
    CommentsRepositoryImpl(getIt<CommentsApi>()),
  );

  getIt.get<TokenStorage>().initialize(getIt<SynchronizationService>(), getIt<NotificationsService>());
}
