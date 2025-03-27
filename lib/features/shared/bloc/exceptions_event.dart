import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';

abstract class ExceptionsEvent {}

class SetExceptionsEvent extends ExceptionsEvent {
  final bool isException;
  final ExceptionTypes exceptionType;
  final String message;

  SetExceptionsEvent({required this.isException, required this.exceptionType, required this.message});
}