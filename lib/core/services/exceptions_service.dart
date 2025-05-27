import 'package:dio/dio.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';

/// Defines methods for handling exceptions.
abstract class ExceptionsService {
  /// Handles Dio HTTP errors.
  Future httpError(DioException exception);
}

/// Implements exception handling with toast notifications.
class ExceptionsServiceImpl extends ExceptionsService {
  final MyToastService myToastService;
  ExceptionsServiceImpl(this.myToastService);

  /// Processes HTTP errors and shows error message via toast.
  @override
  Future httpError(DioException exception) async {
    if (exception.response != null) {
      print(exception.response?.data);
      print(exception.response?.headers);
      print(exception.response?.requestOptions);
      String? msg;

      try{
        msg = exception.response?.data['Message'];
      }
      catch(e){}
      msg ??= exception.response?.statusMessage;


      if (msg != null) {
        myToastService.showError(msg);
      }
    }
  }
}
