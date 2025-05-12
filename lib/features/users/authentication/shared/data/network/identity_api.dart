import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:mtaa_frontend/core/services/exceptions_service.dart';
import 'package:mtaa_frontend/core/services/internet_checker.dart';
import 'package:mtaa_frontend/features/users/authentication/log-in/data/models/requests/logInRequest.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/models/token.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/data/models/requests/StartSignUpEmailVerificationRequest.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/data/models/requests/signUpByEmailRequest.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/data/models/requests/signUpVerifyEmailRequest.dart';

abstract class IdentityApi {
  Future<bool> signUpStartEmailVerification(StartSignUpEmailVerificationRequest request);
  Future<bool> signUpVerifyEmail(SignUpVerifyEmailRequest request);
  Future<Token?> signUpByEmail(SignUpByEmailRequest request);
  Future<Token?> logIn(LogInRequest request);
}

class IdentityImplApi extends IdentityApi {
  final Dio dio;
  final String controllerName = 'Identity';
  CancelToken cancelToken = CancelToken();
  final ExceptionsService exceptionsService;
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  IdentityImplApi(this.dio, this.exceptionsService);

  @override
  Future<bool> signUpStartEmailVerification(StartSignUpEmailVerificationRequest request) async {
    if(await InternetChecker.fullIsFlightMode()) return false;
    final fullUrl = '$controllerName/sign-up-start-email-verification';
    try {
      await dio.post(fullUrl, data: request.toJson());

      await analytics.logEvent(name: 'sign_up_start_email_verification', parameters: {
        'email': request.email,
      });
      return true;
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return false;
    }
  }

  @override
  Future<bool> signUpVerifyEmail(SignUpVerifyEmailRequest request) async {
    if(await InternetChecker.fullIsFlightMode()) return false;
    final fullUrl = '$controllerName/sign-up-verify-email';
    try {
      var res = await dio.post(fullUrl, data: request.toJson());

      await analytics.logEvent(name: 'sign_up_verify_email', parameters: {
        'email': request.email,
      });
      return res.data as bool;
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return false;
    }
  }

  @override
  Future<Token?> signUpByEmail(SignUpByEmailRequest request) async {
    if(await InternetChecker.fullIsFlightMode()) return null;
    final fullUrl = '$controllerName/sign-up-by-email';
    try {
      var res = await dio.post(fullUrl, data: request.toJson());

      await analytics.logEvent(name: 'sign_up_by_email', parameters: {
        'email': request.email,
      });
      return Token.fromJson(res.data);
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return null;
    }
  }

  @override
  Future<Token?> logIn(LogInRequest request) async {
    if(await InternetChecker.fullIsFlightMode()) return null;
    final fullUrl = '$controllerName/log-in';
    try {
      var res = await dio.post(fullUrl, data: request.toJson());

      await analytics.logEvent(name: 'log_in');
      return Token.fromJson(res.data);
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return null;
    }
  }
}
