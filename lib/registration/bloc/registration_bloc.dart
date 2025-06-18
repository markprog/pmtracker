import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:shared_preferences_repository/storage_repository.dart';

import '../../login/login.dart';
import '../models/models.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc({
    required AuthenticationRepository authenticationRepository,
    required SharedPreferencesHelper storageRepository,
  })  : _authenticationRepository = authenticationRepository,
        _storageRepository = storageRepository,
        super(const RegistrationState()) {
    on<RegistrationUsernameChanged>(_onUsernameChanged);
    on<RegistrationEmailChanged>(_onEmailChanged);
    on<RegistrationPasswordChanged>(_onPasswordChanged);
    on<RegistrationConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegistrationSubmitted>();
  }

  final AuthenticationRepository _authenticationRepository;
  final SharedPreferencesHelper _storageRepository;

  void _onUsernameChanged(
      RegistrationUsernameChanged event, Emitter<RegistrationState> emit) {
    final username = Name.dirty(event.username);
    emit(state.copyWith(
        name: username,
        isValid: Formz.validate(
            [state.email, state.password, state.confirmPassword, username])));
  }

  void _onEmailChanged(
      RegistrationEmailChanged event, Emitter<RegistrationState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
        email: email,
        isValid: Formz.validate(
            [state.email, state.password, state.confirmPassword, email])));
  }

  void _onPasswordChanged(
      RegistrationPasswordChanged event, Emitter<RegistrationState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
        password: password,
        isValid: Formz.validate(
            [state.email, state.password, state.confirmPassword, password])));
  }

  void _onConfirmPasswordChanged(RegistrationConfirmPasswordChanged event,
      Emitter<RegistrationState> emit) {
    final confirmPassword =
        ConfirmPassword.dirty(confirmPassword: event.confirmPassword, value: state.password.value);
    emit(state.copyWith(
        confirmPassword: confirmPassword,
        isValid: Formz.validate([
          state.email,
          state.password,
          state.confirmPassword,
          confirmPassword
        ])));
  }
  void _onSubmitted(RegistrationSubmitted event, Emitter<RegistrationState> emit) {
    
  }
}
