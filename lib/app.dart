import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app_w_bloc/splash/view/splash_page.dart';
import 'package:matrix_app_w_bloc/theme/default_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences_repository/storage_repository.dart';
import 'package:tasks_repository/tasks_repository.dart';
import 'package:user_repository/user_repository.dart';

import 'authentication/bloc/authentication_bloc.dart';
import 'home/view/home_page.dart';
import 'login/view/login_page.dart';
import 'navigation/view/navigation_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthenticationRepository(storage: Provider.of<SharedPreferencesHelper>(context, listen: false),),
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider(create: (_) => UserRepository()),
        RepositoryProvider(create: (_) => TasksRepository()),
      ],
      child: BlocProvider(
        lazy: false,
        create: (context) => AuthenticationBloc(
          storageRepository: Provider.of<SharedPreferencesHelper>(context, listen: false),
          authenticationRepository: context.read<AuthenticationRepository>(),
          userRepository: context.read<UserRepository>(),
        )..add(AuthenticationSubscriptionRequested()),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.defaultTheme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            print('Authentication status changed: ${state.status}');
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  NavigationPage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unknown:
                _navigator.pushAndRemoveUntil<void>(
                  NavigationPage.route(),
                      (route) => false,
                );
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
