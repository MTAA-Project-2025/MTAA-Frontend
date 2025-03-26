import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/groups/presentation/screens/userGroupListScreen.dart';
import 'package:mtaa_frontend/features/images/data/storages/my_image_storage.dart';
import 'package:mtaa_frontend/features/images/presentation/widgets/test.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/screens/add_post_screen.dart';
import 'package:mtaa_frontend/features/posts/presentation/screens/full_post_screen.dart';
import 'package:mtaa_frontend/features/posts/presentation/screens/post_recommendations_screen.dart';
import 'package:mtaa_frontend/features/posts/presentation/screens/posts_global_search_screen.dart';
import 'package:mtaa_frontend/features/settings/presentation/screens/user_settings_screen.dart';
import 'package:mtaa_frontend/features/users/account/data/network/account_api.dart';
import 'package:mtaa_frontend/features/users/account/presentation/screens/firstUpdateAvatarScreen.dart';
import 'package:mtaa_frontend/features/users/account/presentation/screens/firstUpdateBirthDateScreen.dart';
import 'package:mtaa_frontend/features/users/account/presentation/screens/firstUpdateDisplayNameScreen.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/network/identity_api.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/presentation/screens/createAccountScreen.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/presentation/screens/signUpVerificationByEmailScreen.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/presentation/screens/startScreen.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/presentation/screens/startSignUpScreen.dart';
import 'package:mtaa_frontend/features/users/authentication/log-in/presentation/screens/logInScreen.dart';

class AppRouter {
  static GoRouter createRouter(String initialRoute) {
    return GoRouter(
      initialLocation: initialRoute,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const StartScreen(),
        ),
        GoRoute(
          path: startSignUpPageRoute,
          builder: (context, state) => StartSignUpScreen(
            identityApi: getIt<IdentityApi>(),
          ),
        ),
        GoRoute(
          path: signUpVerificationByEmailScreenRoute,
          builder: (context, state) => SignUpVerificationByEmailScreen(identityApi: getIt<IdentityApi>()),
        ),
        GoRoute(
          path: createAccountScreenRoute,
          builder: (context, state) => CreateAccountScreen(identityApi: getIt<IdentityApi>()),
        ),
        GoRoute(
          path: firstUpdateDisplayNameScreenRoute,
          builder: (context, state) => FirstUpdateDisplayNameScreen(accountApi: getIt<AccountApi>()),
        ),
        GoRoute(
          path: firstUpdateBirthDateScreenRoute,
          builder: (context, state) => FirstUpdateBirthDateScreen(accountApi: getIt<AccountApi>()),
        ),
        GoRoute(
          path: firstUpdateAvatarScreenRoute,
          builder: (context, state) => FirstUpdateAvatarScreen(accountApi: getIt<AccountApi>()),
        ),
        GoRoute(
          path: userGroupListScreenRoute,
          builder: (context, state) => UserGroupListScreen(identityApi: getIt<IdentityApi>()),
        ),
        GoRoute(
          path: userGroupListScreenRoute,
          builder: (context, state) => UserGroupListScreen(identityApi: getIt<IdentityApi>()),
        ),
        GoRoute(
          path: userRecommendationsScreenRoute,
          builder: (context, state) => PostRecommendationsScreen(repository: getIt<PostsRepository>())
        ),
        GoRoute(
          path: addPostScreenRoute,
          builder: (context, state) => AddPostScreen(repository: getIt<PostsRepository>(), toastService: getIt<MyToastService>(), imageStorage: getIt<MyImageStorage>())
        ),
        GoRoute(
          path: userSettingsScreenRoute,
          builder: (context, state) => UserSettingsScreen()
        ),
        GoRoute(
          path: globalSearchScreenRoute,
          builder: (context, state) => PostsGlobalSearchScreen(repository: getIt<PostsRepository>())
        ),
        GoRoute(
          path: '$fullPostScreenRoute/:id',	
          builder: (context, state) {
            FullPostResponse? post;
            if(state.extra!=null && state.extra is FullPostResponse) post = state.extra as FullPostResponse;
            String? postId = state.pathParameters['id']!;
            return FullPostScreen(repository: getIt<PostsRepository>(), postId: postId, post: post);
          }
        ),
        GoRoute(
          path: '/test',
          builder: (context, state) => HomePage(title: '213'),
        ),
        GoRoute(
          path: logInScreenRoute,
          builder: (context, state) => LogInScreen(
            identityApi: getIt<IdentityApi>(),
          ),
        ),
      ],
    );
  }
}
