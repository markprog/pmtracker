import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError { empty, mismatch }

class ConfirmPassword extends FormzInput<String, ConfirmPasswordValidationError> {
  final String confirmPassword;
  const ConfirmPassword.pure({this.confirmPassword = ''}) : super.pure('');
  const ConfirmPassword.dirty({required this.confirmPassword, String value = ''}) : super.dirty(value);

  @override
  ConfirmPasswordValidationError? validator(String value) {
    if (value.isEmpty) return ConfirmPasswordValidationError.empty;
    if (value != confirmPassword) return ConfirmPasswordValidationError.mismatch;
    return null;
  }
}