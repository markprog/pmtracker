import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';

import '../../constants/AppIcons.dart';
import '../bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _Logo(),
                const Padding(padding: EdgeInsets.only(bottom: 12)),
                _GoogleSignInButton(),
                const Padding(padding: EdgeInsets.only(bottom: 12)),
                _EmailInput(),
                const Padding(padding: EdgeInsets.only(bottom: 12)),
                _PasswordInput(),
                const Padding(padding: EdgeInsets.only(bottom: 12)),
                _LoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppIcons.homeMat,
      color: Colors.white,
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
  const _GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      side: const BorderSide(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
      // TODO: Add Google Service
      onPressed: () async {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppIcons.googleIcon,
            width: 18,
            height: 18,
          ),
          const SizedBox(width: 10),
          Text(
          // TODO: Add text from localization
            "Google Sign In",
            style: Theme.of(context).textTheme.bodyLarge
          ),
        ],
      ),
    );
  }
}



class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.email.displayError,
    );

    return TextField(
      style: Theme.of(context).textTheme.bodyMedium,
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: (username) {
        context.read<LoginBloc>().add(LoginUsernameChanged(username));
      },
      decoration: InputDecoration(
        // TODO: Add localization
        labelText: 'email',
        errorText: displayError != null ? 'invalid username' : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginBloc bloc) => bloc.state.password.displayError,
    );

    return TextField(
      style: Theme.of(context).textTheme.bodyMedium,
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: (password) {
        context.read<LoginBloc>().add(LoginPasswordChanged(password));
      },
      obscureText: true,
      decoration: InputDecoration(
        // TODO: Add localization
        labelText: 'password',
        errorText: displayError != null ? 'invalid password' : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgressOrSuccess = context.select(
      (LoginBloc bloc) => bloc.state.status.isInProgressOrSuccess,
    );

    if (isInProgressOrSuccess) return const CircularProgressIndicator();

    final isValid = context.select((LoginBloc bloc) => bloc.state.isValid);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        key: const Key('loginForm_continue_raisedButton'),
        onPressed: isValid
            ? () => context.read<LoginBloc>().add(const LoginSubmitted())
            : null,
        // TODO: Add localization
        child: Text('Login', style: Theme.of(context).textTheme.bodyLarge,),
      ),
    );
  }
}
