import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
  MaxLengthValidator(200, errorText: 'Password must be at most 200 digits long'),
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'Email is required'),
  EmailValidator(errorText: "Enter a valid email address"),
]);

final usernameValidator = MultiValidator([
  RequiredValidator(errorText: 'Username is required'),
  MinLengthValidator(3, errorText: 'Username must be at least 3 digits long'),
  MaxLengthValidator(50, errorText: 'Username must be at most 50 digits long'),
  AllowedCharactersValidator(allowedCharacters: 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_', errorText: 'username must contain only letters, numbers, and underscores'),
]);

final abstractNameValidator = MultiValidator([
  RequiredValidator(errorText: 'Name is required'),
  MinLengthValidator(3, errorText: 'Name must be at least 3 digits long'),
  MaxLengthValidator(100, errorText: 'Name must be at most 100 digits long'),
  AllowedCharactersValidator(allowedCharacters: 'АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯабвгґдеєжзиіїйклмнопрстуфхцчшщьюяĆćČčĎďĐđŁłŃńŇňŐőŘřŚśŠšŤťŽžљњћџђњћџABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿĀāĂăĄąĆćĈĉĊċČčĎďĐđĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħĨĩĪīĬĭĮįİıĴĵĶķĹĺĻļĽľĿŀŁłŃńŅņŇňŉŌōŎŏŐőŒœŔŕŖŗŘřŚśŜŝŞşŠšŢţŤťŦŧŨũŪūŬŭŮůŰűŲųŴŵŶŷŸŹźŻżŽžǺǻǼǽǾǿȘșȚțəɐɑɒɓɔɕɖɗəɛɜɡɣɥɨɪɫɬɭɯɰɱɲɳɵɹɻɽɾʀʁʂʃʄʅʉʊʋʌʍʎʏʐʑʒʔμאבגдהוזחטיכלמנסעפצקרשתاآبتثجحخدذرزسشصضطظعغفقكلمنهوياأإآةىءصقفعظعظةلىكسمنتيكى_\- ', errorText: 'Name must contain only letters, numbers, and underscores'),
]);

final phoneValidator = MultiValidator([
  RequiredValidator(errorText: 'Phone number is required'),
  PatternValidator(r'^\+?[0-9]\d{1,14}$', errorText: 'Enter a valid phone number'),
]);

class EmailOrPhoneValidator extends FieldValidator<String> {
  EmailOrPhoneValidator({required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return emailValidator.isValid(value) || phoneValidator.isValid(value);
  }
}

class AllowedCharactersValidator extends FieldValidator<String> {
  final String allowedCharacters;
  AllowedCharactersValidator({required this.allowedCharacters, required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) {
    if (value == null) return false;
    final RegExp regExp = RegExp("^[$allowedCharacters]+\$");
    return regExp.hasMatch(value);
  }
}

final loginValidator = MultiValidator([
  RequiredValidator(errorText: 'This field is required'),
  EmailOrPhoneValidator(errorText: 'Enter a valid email or phone number'),
]);

bool isImage(XFile file) {
  final extension = file.path.split('.').last.toLowerCase();
  return ['jpg', 'jpeg', 'png'].contains(extension);
}

final descriptionValidator = MultiValidator([
  RequiredValidator(errorText: 'Description is required'),
  MinLengthValidator(3, errorText: 'Description must be at least 3 digits long'),
  MaxLengthValidator(3000, errorText: 'Description must be at most 3000 digits long')
]);

final commentValidator = MultiValidator([
  RequiredValidator(errorText: 'Comment cannot be empty'),
  MaxLengthValidator(2000, errorText: 'Name must be at most 2000 digits long')
]);


final double minPostImageAspectRatio = 0.5;
final double maxPostImageAspectRatio = 2;