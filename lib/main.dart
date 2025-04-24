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
import 'package:mtaa_frontend/features/notifications/data/network/notificationsService.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/blocs/verification_email_phone_bloc.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';
import 'package:mtaa_frontend/themes/app_theme.dart';
import 'package:mtaa_frontend/themes/bloc/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/themes/bloc/theme_state.dart';
import 'package:mtaa_frontend/core/route/router.dart' as router;

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

  await Hive.openBox(currentUserDataBox);
  await Hive.openBox<List>(postsDataBox);
  await Hive.openBox<List>(locationPointsDataBox);
  await Hive.openBox<UserPositionHive>(prevUserLocationDataBox);

  const environment = String.fromEnvironment('ENV', defaultValue: 'development');
  AppConfig.loadConfig(environment);
  setupDependencies();
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  String initialRoute = await getInitialRoute();

  await FMTCObjectBoxBackend().initialise();
  await FMTCStore(tilesBox).manage.create();
  var sse = getIt<NotificationsService>();
  await sse.startSSE();

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
    ],
    child: MyApp(initialRoute: initialRoute,),
  ));
}

  Future<bool> isAuthorized() async {
    final token = await TokenStorage.getToken();
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
  const MyApp({super.key, required this.initialRoute});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    InternetChecker.initialize();
  }

  @override
  void dispose() {
    InternetChecker.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: 'Likely',
          theme: AppTheme.lightTheme(context),
          darkTheme: AppTheme.darkTheme(context),
          themeMode: state.themeMode,
          routerConfig: router.AppRouter.createRouter(widget.initialRoute),
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
