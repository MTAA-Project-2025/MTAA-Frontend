abstract class VerificationEmailPhoneEvent {}

class SetVerificationEmailPhoneEvent extends VerificationEmailPhoneEvent {
  final String newValue;
  SetVerificationEmailPhoneEvent(this.newValue);
}