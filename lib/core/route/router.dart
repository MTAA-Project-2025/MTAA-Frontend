import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/groups/presentation/screens/userGroupListScreen.dart';
import 'package:mtaa_frontend/features/images/data/storages/my_image_storage.dart';
import 'package:mtaa_frontend/features/images/presentation/widgets/test.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/add_location_request.dart';
import 'package:mtaa_frontend/features/locations/data/models/responses/simple_location_point_response.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/locations/presentation/screens/location_cluster_points_screen.dart';
import 'package:mtaa_frontend/features/locations/presentation/screens/main_location_map_screen.dart';
import 'package:mtaa_frontend/features/locations/presentation/screens/one_point_screen_widget.dart';
import 'package:mtaa_frontend/features/locations/presentation/screens/saved_location_points_screen.dart';
import 'package:mtaa_frontend/features/notifications/data/repositories/notificationsRepository.dart';
import 'package:mtaa_frontend/features/notifications/presentation/screens/notificationsScreen.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/screens/add_post_location_screen.dart';
import 'package:mtaa_frontend/features/posts/presentation/screens/add_post_screen.dart';
import 'package:mtaa_frontend/features/posts/presentation/screens/full_post_screen.dart';
import 'package:mtaa_frontend/features/posts/presentation/screens/post_recommendations_screen.dart';
import 'package:mtaa_frontend/features/posts/presentation/screens/posts_global_search_screen.dart';
import 'package:mtaa_frontend/features/posts/presentation/screens/update_post_screen.dart';
import 'package:mtaa_frontend/features/settings/presentation/screens/user_settings_screen.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicFullAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/network/account_api.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/account/presentation/screens/accountInformationScreen.dart';
import 'package:mtaa_frontend/features/users/account/presentation/screens/firstUpdateAvatarScreen.dart';
import 'package:mtaa_frontend/features/users/account/presentation/screens/firstUpdateBirthDateScreen.dart';
import 'package:mtaa_frontend/features/users/account/presentation/screens/firstUpdateDisplayNameScreen.dart';
import 'package:mtaa_frontend/features/users/account/presentation/screens/followersScreen.dart';
import 'package:mtaa_frontend/features/users/account/presentation/screens/friendsScreen.dart';
import 'package:mtaa_frontend/features/users/account/presentation/screens/globalSearchScreen.dart';
import 'package:mtaa_frontend/features/users/account/presentation/screens/publicAccountInformationScreen.dart';
import 'package:mtaa_frontend/features/users/account/presentation/screens/updateAccountScreen.dart';
import 'package:mtaa_frontend/features/users/account/presentation/screens/updateAvatarScreen.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/network/identity_api.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/presentation/screens/createAccountScreen.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/presentation/screens/signUpVerificationByEmailScreen.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/presentation/screens/startScreen.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/presentation/screens/startSignUpScreen.dart';
import 'package:mtaa_frontend/features/users/authentication/log-in/presentation/screens/logInScreen.dart';
import 'package:uuid/uuid_value.dart';

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
          builder: (context, state) => FirstUpdateAvatarScreen(accountApi: getIt<AccountApi>(), toastService: getIt<MyToastService>()),
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
          path: accountProfileScreenRoute,
          builder: (context, state) => AccountInformationScreen(repository: getIt<AccountRepository>()),
        ),
        GoRoute(
          path: publicAccountInformationScreenRoute,
          builder: (context, state) {
            String? userId;
            if(state.extra!=null && state.extra is String) userId = state.extra as String;
            
            return PublicAccountInformationScreen(repository: getIt<AccountRepository>(), userId:userId!);
          }  
        ),
        GoRoute(
          path: updateUserScreenRoute,
          builder: (context, state) => UpdateAccountScreen(repository: getIt<AccountRepository>(), toastService: getIt<MyToastService>(),),
        ),
        GoRoute(
          path: updateAccountAvatarRoute,
          builder: (context, state) => UpdateAvatarScreen(repository: getIt<AccountRepository>(), toastService: getIt<MyToastService>()),
        ),
        GoRoute(
          path: addPostScreenRoute,
          builder: (context, state) => AddPostScreen(repository: getIt<PostsRepository>(), toastService: getIt<MyToastService>(), imageStorage: getIt<MyImageStorage>())
        ),
        GoRoute(
          path: updatePostScreenRoute,
          builder: (context, state) {
            FullPostResponse? post;
            if(state.extra!=null && state.extra is FullPostResponse) post = state.extra as FullPostResponse;
            
            return UpdatePostScreen(repository: getIt<PostsRepository>(), toastService: getIt<MyToastService>(), imageStorage: getIt<MyImageStorage>(), post:post!, locationsRepository: getIt<LocationsRepository>());
          }  
        ),
        GoRoute(path: onePointScreenRoute,
          builder: (context, state) {
            SimpleLocationPointResponse? point;
            if(state.extra!=null && state.extra is SimpleLocationPointResponse) point = state.extra as SimpleLocationPointResponse;
            String? pointIdStr = state.pathParameters['id'];
            UuidValue? pointId;
            if(pointIdStr!=null && pointIdStr.isNotEmpty) {
              pointId = UuidValue.fromString(pointIdStr);
            }
            return OnePointScreenScreen(repository: getIt<LocationsRepository>(), toastService: getIt<MyToastService>(), point: point, pointId: pointId,);
          }
        ),
        GoRoute(
          path: userSettingsScreenRoute,
          builder: (context, state) => UserSettingsScreen()
        ),
        GoRoute(
          path: globalSearchScreenRoute,
          builder: (context, state) => GlobalSearchScreen(postsRepository: getIt<PostsRepository>(), usersRepository: getIt<AccountRepository>(),)
        ),
        GoRoute(path: userMapScreenRoute,
          builder: (context, state) => MainLocationMapScreen(repository: getIt<LocationsRepository>(),toastService: getIt<MyToastService>())
        ),
        GoRoute(
          path: '$fullPostScreenRoute/:id',	
          builder: (context, state) {
            FullPostResponse? post;
            if(state.extra!=null && state.extra is FullPostResponse) post = state.extra as FullPostResponse;
            String? postId = state.pathParameters['id']!;
            return FullPostScreen(repository: getIt<PostsRepository>(), postId: postId, post: post, locationsRepository: getIt<LocationsRepository>());
          }
        ),
        GoRoute(
          path: addPostLocationScreenRoute,	
          builder: (context, state) {
            AddLocationRequest? request;
            if(state.extra!=null && state.extra is AddLocationRequest) request = state.extra as AddLocationRequest;
            return AddPostLocationScreen(toastService: getIt<MyToastService>(), addLocationRequest: request!);
          }
        ),
        GoRoute(
          path: '$locationClusterPointsScreenRoute/:id',	
          builder: (context, state) {
            String? clusterId = state.pathParameters['id']!;
            return LocationClusterPointsScreen(repository: getIt<LocationsRepository>(), clusterId: UuidValue.fromString(clusterId));
          }
        ),
        GoRoute(
          path: locationClusterPointsScreenRoute,	
          builder: (context, state) {
            return SavedLocationsPointsScreen(repository: getIt<PostsRepository>());
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
        GoRoute(
          path: followersScreenRoute,
          builder: (context, state) => FollowersScreen(repository: getIt<AccountRepository>())
        ),
        GoRoute(
          path: friendsScreenRoute,
          builder: (context, state) => FriendsScreen(repository: getIt<AccountRepository>())
        ),
        GoRoute(
          path: notificationsScreenRoute,
          builder: (context, state) => NotificationsScreen(repository: getIt<NotificationsRepository>())
        ),
      ],
    );
  }
}
