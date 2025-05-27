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
    TokenStorageImpl(),
  );
  print("TokenStorage registered");
  Dio dio = Dio(BaseOptions(baseUrl: AppConfig.config.baseUrl));
  dio.interceptors.add(AuthInterceptor(getIt<TokenStorage>()));
  dio.interceptors.add(ErrorInterceptor());

  getIt.registerSingleton<Dio>(dio);
  print("Dio registered");
  getIt.get<TokenStorage>().initializeDio(dio);

  getIt.registerSingleton<MyToastService>(
    MyToastServiceImpl(),
  );
  print("MyToastService registered");
  getIt.registerSingleton<MyImageStorage>(
    MyImageStorageImpl(),
  );
  print("MyImageStorage registered");

  getIt.registerSingleton<MyDbContext>(
    MyDbContext(),
  );
  print("MyDbContext registered");

  getIt.registerSingleton<TimeFormatingService>(
    TimeFormatingServiceImpl(),
  );
  print("TimeFormatingService registered");
  getIt.registerSingleton<NumberFormatingService>(
    NumberFormatingServiceImpl(),
  );
  print("NumberFormatingServiceImpl registered");
  getIt.registerSingleton<ExceptionsService>(
    ExceptionsServiceImpl(getIt<MyToastService>()),
  );
  print("ExceptionsService registered");
  getIt.registerSingleton<PresetAvatarImagesApi>(
    PresetAvatarImagesApiImpl(getIt<Dio>()),
  );
  print("PresetAvatarImagesApi registered");
  getIt.registerSingleton<IdentityApi>(
    IdentityImplApi(getIt<Dio>(), getIt<ExceptionsService>()),
  );
  print("IdentityApi registered");

  getIt.registerSingleton<LocationsApi>(
    LocationsApiImpl(getIt<Dio>(), getIt<ExceptionsService>()),
  );
  print("LocationsApi registered");

  getIt.registerSingleton<PostsApi>(
    PostsApiImpl(getIt<Dio>(), getIt<ExceptionsService>()),
  );
  print("PostsApi registered");

  getIt.registerSingleton<PhoneNotificationsService>(
    PhoneNotificationsServiceImpl(),
  );
  print("PhoneNotificationsServiceImpl registered");

  getIt.registerSingleton<PostsStorage>(
    PostsStorageImpl(getIt<MyDbContext>(),
    getIt<MyImageStorage>(),
    getIt<Dio>(),
    getIt<PhoneNotificationsService>(),
    getIt<TokenStorage>()),
  );
  print("PostsStorage registered");
  getIt.registerSingleton<PostsRepository>(
    PostsRepositoryImpl(getIt<PostsApi>(), getIt<PostsStorage>(), getIt<TokenStorage>()),
  );
  print("PostsRepository registered");

  getIt.registerSingleton<LocationsStorage>(
    LocationsStorageImpl(),
  );
  print("LocationsStorage registered");
  getIt.registerSingleton<LocationsRepository>(
    LocationsRepositoryImpl(getIt<LocationsApi>(),
    getIt<PostsStorage>(),
    getIt<LocationsStorage>()),
  );
  print("LocationsRepository registered");

  getIt.registerSingleton<AccountApi>(
    AccountApiImpl(getIt<Dio>(), getIt<ExceptionsService>()),
  );
  print("AccountApi registered");
  getIt.registerSingleton<AccountStorage>(
    AccountStorageImpl()
  );
  print("AccountStorage registered");

  getIt.registerSingleton<AccountRepository>(
    AccountRepositoryImpl(getIt<AccountApi>(), getIt<AccountStorage>()),
  );
  print("AccountRepository registered");
  
  getIt.registerSingleton<NotificationsApi>(
    NotificationsApiImpl(getIt<Dio>(), getIt<ExceptionsService>()),
  );
  print("NotificationsApi registered");

  getIt.registerSingleton<NotificationsRepository>(
    NotificationsRepositoryImpl(getIt<NotificationsApi>()),
  );
  print("NotificationsRepository registered");

  getIt.registerSingleton<VersionItemsApi>(
    VersionItemsApiImpl(getIt<Dio>(), getIt<ExceptionsService>()),
  );
  print("VersionItemsApi registered");

  getIt.registerSingleton<VersionItemsStorage>(
    VersionItemsStorageImpl(),
  );
  print("VersionItemsStorage registered");

  getIt.registerSingleton<SynchronizationService>(
    SynchronizationServiceImpl(getIt<PostsApi>(),
        getIt<LocationsApi>(),
        getIt<PostsStorage>(),
        getIt<VersionItemsApi>(),
        getIt<VersionItemsStorage>(),
        getIt<AccountApi>(),
        getIt<TokenStorage>())
  );
  print("SynchronizationService registered");

  getIt.registerSingleton<NotificationsService>(
  NotificationsServiceImpl(getIt<MyToastService>(),
        getIt<SynchronizationService>()),
  );
  print("NotificationsService registered");
  getIt.registerSingleton<CommentsApi>(
    CommentsApiImpl(getIt<Dio>(), getIt<ExceptionsService>()),
  );
  print("CommentsApi registered");
  getIt.registerSingleton<CommentsRepository>(
    CommentsRepositoryImpl(getIt<CommentsApi>()),
  );
  print("CommentsRepository registered");

  getIt.get<TokenStorage>().initialize(getIt<SynchronizationService>(), getIt<NotificationsService>());
}
