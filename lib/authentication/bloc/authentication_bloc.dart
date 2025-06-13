import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences_repository/storage_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository,
      required UserRepository userRepository,
      required SharedPreferencesHelper storageRepository})
      : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        _storageRepository = storageRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthenticationLogoutPressed>(_onLogoutPressed);
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final SharedPreferencesHelper _storageRepository;

  Future<void> _onSubscriptionRequested(
    AuthenticationSubscriptionRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    return emit.onEach(
      _authenticationRepository.status,
      onData: (status) async {
        final userFromShared = _storageRepository.user;
        switch (status) {
          case AuthenticationStatus.unauthenticated:
            return emit(const AuthenticationState.unauthenticated());
          case AuthenticationStatus.authenticated:
            User? user = await _tryGetUser();
            if (user != null) {
              await _storageRepository.setUser(jsonEncode(user.toJson()));
              return emit(AuthenticationState.authenticated(user));
            } else if (_storageRepository.user.isNotEmpty) {
              try {
                user = User.fromJson(jsonDecode(_storageRepository.user));
                return emit(AuthenticationState.authenticated(user));
              } catch (_) {
                return emit(const AuthenticationState.unauthenticated());
              }
            } else {
              return emit(const AuthenticationState.unauthenticated());
            }
          case AuthenticationStatus.unknown:
            if (userFromShared.isNotEmpty) {
              try {
                final User user = User.fromJson(jsonDecode(userFromShared));
                // Можно тут еще проверить токен, если его срок годности важен
                return emit(AuthenticationState.authenticated(user));
              } catch (_) {
                // Если не смогли декодировать
                return emit(const AuthenticationState.unauthenticated());
              }
            } else {
              return emit(const AuthenticationState.unauthenticated());
            }
        }
      },
      onError: addError,
    );
  }

  void _onLogoutPressed(
    AuthenticationLogoutPressed event,
    Emitter<AuthenticationState> emit,
  ) {
    _storageRepository.clearUserData();
    _authenticationRepository.logout();
    emit(AuthenticationState.unauthenticated());
  }

  Future<User?> _tryGetUser() async {
      final user = await _userRepository.getUser(_storageRepository.accessToken);
      return user;
  }
}
