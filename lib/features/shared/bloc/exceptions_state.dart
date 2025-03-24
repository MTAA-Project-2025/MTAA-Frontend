import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';

class ExceptionsState {
  final bool isException;
  final ExceptionTypes exceptionType;
  final String message;

  ExceptionsState({required this.isException,
  required this.exceptionType,
  required this.message});
}