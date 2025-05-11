import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mtaa_frontend/core/config/app_config.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/constants/storages/storage_boxes.dart';
import 'package:mtaa_frontend/core/services/internet_checker.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/add_image_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/add_location_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/add_post_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/crop_aspect_ratio_preset_custom_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/locations/simple_point_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/locations/user_position_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/posts/full_post_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/posts/my_image_group_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/posts/my_image_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/posts/simple_user_hive.dart';
import 'package:mtaa_frontend/domain/hive_data/users/user_full_account_hive.dart';
import 'package:mtaa_frontend/features/notifications/data/network/notificationsService.dart';
import 'package:mtaa_frontend/features/posts/bloc/scheduled_posts_bloc.dart';
import 'package:mtaa_frontend/features/posts/bloc/scheduled_posts_event.dart';
import 'package:mtaa_frontend/features/posts/data/storages/posts_storage.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/synchronization/synchronization_service.dart';
import 'package:mtaa_frontend/features/users/account/bloc/account_bloc.dart';
import 'package:mtaa_frontend/features/users/account/bloc/account_events.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/blocs/verification_email_phone_bloc.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';
import 'package:mtaa_frontend/themes/app_theme.dart';
import 'package:mtaa_frontend/themes/bloc/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/themes/bloc/theme_state.dart';
import 'package:mtaa_frontend/core/route/router.dart' as router;
import 'package:timezone/data/latest.dart' as tz;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FullPostHiveAdapter());
  Hive.registerAdapter(MyImageGroupHiveAdapter());
  Hive.registerAdapter(MyImageHiveAdapter());
  Hive.registerAdapter(SimpleUserHiveAdapter());
  Hive.registerAdapter(AddImageHiveAdapter());
  Hive.registerAdapter(AddLocationHiveAdapter());
  Hive.registerAdapter(AddPostHiveAdapter());
  Hive.registerAdapter(CropAspectRatioPresetCustomHiveAdapter());
  Hive.registerAdapter(UserPositionHiveAdapter());
  Hive.registerAdapter(SimplePointHiveAdapter());
  Hive.registerAdapter(UserFullAccountHiveAdapter());

  await Hive.openBox(currentUserDataBox);
  await Hive.openBox<List>(postsDataBox);
  await Hive.openBox<AddPostHive>(tempAddPostDataBox);
  await Hive.openBox<List>(locationPointsDataBox);
  await Hive.openBox<List>(scheduledAddPostDataBox);
  await Hive.openBox<UserPositionHive>(prevUserLocationDataBox);
  await Hive.openBox(accountDataBox);

  tz.initializeTimeZones();

  const environment = String.fromEnvironment('ENV', defaultValue: 'development');
  AppConfig.loadConfig(environment);
  setupDependencies();
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  String initialRoute = await getInitialRoute();

  await FMTCObjectBoxBackend().initialise();
  await FMTCStore(tilesBox).manage.create();
  var sse = getIt<NotificationsService>();
  var tokenStorage = getIt<TokenStorage>();
  var token = await tokenStorage.getToken();
  if (token != null && token.isNotEmpty) {
    sse.startSSE(token);
  }

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(
        create: (_) => ThemeBloc(),
      ),
      BlocProvider<VerificationEmailPhoneBloc>(
        create: (_) => VerificationEmailPhoneBloc(),
      ),
      BlocProvider<ExceptionsBloc>(
        create: (_) => ExceptionsBloc(),
      ),
      BlocProvider<AccountBloc>(
        create: (_) => AccountBloc(),
      ),
      BlocProvider<ScheduledPostsBloc>(
        create: (_) => ScheduledPostsBloc(),
      ),
    ],
    child: MyApp(
      initialRoute: initialRoute,
      accountRepository: getIt<AccountRepository>(),
      postsStorage: getIt<PostsStorage>(),
      synchronizationService: getIt<SynchronizationService>(),
    ),
  ));
}

Future<bool> isAuthorized() async {
  final tokenStorage = getIt<TokenStorage>();
  final token = await tokenStorage.getToken();
  return token != null && token.isNotEmpty;
}

Future<String> getInitialRoute() async {
  var res = await isAuthorized();
  if (res) {
    return userRecommendationsScreenRoute;
  }
  return '/';
}

class MyApp extends StatefulWidget {
  final String initialRoute;
  final AccountRepository accountRepository;
  final PostsStorage postsStorage;
  final SynchronizationService synchronizationService;
  const MyApp({super.key, required this.initialRoute, required this.accountRepository, required this.postsStorage, required this.synchronizationService});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String initialRoute;
  @override
  void initState() {
    super.initState();
    InternetChecker.initialize();
    widget.synchronizationService.initializeSyncLoad();

    initialRoute = widget.initialRoute;

    Future.microtask(() async {
      if (!mounted) return;
      var account = await widget.accountRepository.getFullLocalAccount();
      if (account == null) return;
      if (!context.mounted) return;
      context.read<AccountBloc>().add(LoadAccountEvent(account: account));
    });

    Future.microtask(() async {
      if (!mounted) return;
      var notSyncedPostsHive = await widget.postsStorage.getScheduledPostsHive();
      if (notSyncedPostsHive.isEmpty) return;
      for (var post in notSyncedPostsHive) {
        if (!context.mounted) return;
        context.read<ScheduledPostsBloc>().add(AddScheduledPostHiveEvent(post: post));
      }
    });
  }

  @override
  void dispose() {
    Future.microtask(() async {
      if (!mounted || !context.mounted) return;
      var account = context.read<AccountBloc>().state.account;
      if (account == null) return;
      await widget.accountRepository.setFullLocalAccount(account);
    });
    Future.microtask(() async {
      if (!mounted || !context.mounted) return;
      var notSyncedPostsHive = context.read<ScheduledPostsBloc>().state.notSyncedPostsHive;
      if (notSyncedPostsHive.isEmpty) return;
      await widget.postsStorage.setScheduledPostsHive(notSyncedPostsHive);
    });

    InternetChecker.dispose();
    super.dispose();
  }

  Future setInitialRoute() async {
    initialRoute = await getInitialRoute();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        setInitialRoute();
        ThemeData themeData;
        switch (state.appThemeMode) {
          case AppThemeMode.dark:
            themeData = AppTheme.darkTheme(context);
            break;
          case AppThemeMode.inclusive:
            themeData = AppTheme.inclusiveTheme(context);
            break;
          case AppThemeMode.light:
          default:
            themeData = AppTheme.lightTheme(context);
            break;
        }
        return MaterialApp.router(
          title: 'Likely',
          theme: themeData,
          routerConfig: router.AppRouter.createRouter(initialRoute),
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
