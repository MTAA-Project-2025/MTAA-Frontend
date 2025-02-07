import 'package:form_field_validator/form_field_validator.dart';

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'passwords must have at least one special character')
]);

final passwordLogInValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long')
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'Email is required'),
  EmailValidator(errorText: "Enter a valid email address"),
]);

final usernameValidator = MultiValidator([
  RequiredValidator(errorText: 'Username is required'),
]);

final phoneValidator = MultiValidator([
  RequiredValidator(errorText: 'Phone number is required'),
  PatternValidator(r'^\+?[0-9]{7,15}$', errorText: 'Enter a valid phone number'),
]);

class EmailOrPhoneValidator extends FieldValidator<String> {
  EmailOrPhoneValidator({required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return emailValidator.isValid(value) ||
        phoneValidator.isValid(value);
  }
}

final loginValidator = MultiValidator([
  RequiredValidator(errorText: 'This field is required'),
  EmailOrPhoneValidator(errorText: 'Enter a valid email or phone number'),
]);