import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/features/authentication/shared/blocs/verification_email_phone_event.dart';
import 'package:mtaa_frontend/features/authentication/shared/blocs/verification_email_phone_state.dart';

class VerificationEmailPhoneBloc extends Bloc<VerificationEmailPhoneEvent, VerificationEmailPhoneState> {
  VerificationEmailPhoneBloc() : super(VerificationEmailPhoneState('')) {
    on<SetVerificationEmailPhoneEvent>((event, emit) => emit(VerificationEmailPhoneState(event.newValue)));
  }
}