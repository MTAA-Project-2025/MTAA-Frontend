import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (getIt.isRegistered<BuildContext>()) {
      var context = getIt.get<BuildContext>();
      context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.serverError, message: 'Failed to add post'));
    }

    super.onError(err, handler);
  }
}
