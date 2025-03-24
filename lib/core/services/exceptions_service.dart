import 'package:dio/dio.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';

abstract class ExceptionsService {
  Future httpError(DioException exception);
}

class ExceptionsServiceImpl extends ExceptionsService {
  final MyToastService myToastService;
  ExceptionsServiceImpl(this.myToastService);

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
      if(msg==null){
        msg=exception.response?.statusMessage;
      }


      if (msg != null) {
        myToastService.showError(msg);
      }
    }
  }
}
