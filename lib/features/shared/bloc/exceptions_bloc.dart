import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_state.dart';


class ExceptionsBloc extends Bloc<ExceptionsEvent, ExceptionsState> {
  ExceptionsBloc() : super(ExceptionsState(isException: false, exceptionType: ExceptionTypes.none, message: '')){
    on<SetExceptionsEvent>((event, emit) {
      emit(new ExceptionsState(isException: event.isException, exceptionType: event.exceptionType, message: event.message));
    });
  }
}