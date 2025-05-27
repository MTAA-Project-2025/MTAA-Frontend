import 'package:dio/src/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/notifications/data/network/notificationsService.dart';
import 'package:mtaa_frontend/features/synchronization/synchronization_service.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';
import 'package:mtaa_frontend/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('UserSettingsScreen renders and responds to taps', (tester) async {
    await tester.pumpWidget(await createApp());

    await tester.pumpAndSettle();

    getIt.get<TokenStorage>().saveToken('fake_token');

    GoRouter.of(tester.element(find.byType(Navigator))).go(userSettingsScreenRoute);
    await tester.pumpAndSettle();
    expect(find.text('Log out'), findsOneWidget);
    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsNothing);
  });
}

class FakeTokenStorage implements TokenStorage {
  @override
  Future<void> deleteToken() async{
  }

  @override
  Future<String?> getToken() async{
    return 'fake_token';
  }

  @override
  Future<String?> getUserId() async{
    return 'fake_user_id';
  }

  @override
  Future<void> initialize(SynchronizationService synchronizationService, NotificationsService notificationsService) async {
  }

  @override
  Future initializeDio(Dio dio) async {
  }

  @override
  Future saveFirebaseToken() async{
  }

  @override
  Future<void> saveToken(String token) async{
  }
}
