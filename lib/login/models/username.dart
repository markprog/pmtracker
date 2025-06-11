import 'package:formz/formz.dart';

enum UsernameValidationError { empty }

class Email extends FormzInput<String, UsernameValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) return UsernameValidationError.empty;
    return null;
  }
}
