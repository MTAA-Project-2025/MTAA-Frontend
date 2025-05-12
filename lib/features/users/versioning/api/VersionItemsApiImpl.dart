import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:mtaa_frontend/core/services/exceptions_service.dart';
import 'package:mtaa_frontend/core/services/internet_checker.dart';
import 'package:mtaa_frontend/features/users/versioning/api/VersionItemsApi.dart';
import 'package:mtaa_frontend/features/users/versioning/data/VersionItem.dart';

class VersionItemsApiImpl implements VersionItemsApi {
  final Dio dio;
  final String controllerName = 'Account';
  final ExceptionsService exceptionsService;
  CancelToken cancelToken = CancelToken();

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  VersionItemsApiImpl(this.dio, this.exceptionsService);

  @override
  Future<List<VersionItem>> getVersionItems() async {
    if(await InternetChecker.fullIsFlightMode()) return [];
    final fullUrl = '$controllerName/all-versions';
    try {
      var res = await dio.get(fullUrl);
      List<dynamic> data = res.data;

      await analytics.logEvent(name: 'get_version_items');

      return data.map((item) => VersionItem.fromJson(item)).toList();
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return [];
    }
  }
}