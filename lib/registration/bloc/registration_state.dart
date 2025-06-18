
part of 'registration_bloc.dart';
final class RegistrationState extends Equatable {
  const RegistrationState({
    this.status = FormzSubmissionStatus.initial,
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Name name;
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final bool isValid;

  RegistrationState copyWith({
    FormzSubmissionStatus? status,
    Name? name,
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    bool? isValid,
  }) {
    return RegistrationState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, name, email, password];
}