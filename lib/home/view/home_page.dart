import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_bloc_app/home/bloc/home_bloc.dart';
import 'package:project_repository/project_repository.dart';import 'package:provider/provider.dart';
import 'package:shared_preferences_repository/storage_repository.dart';

import '../../authentication/bloc/authentication_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final storage = Provider.of<SharedPreferencesHelper>(context, listen: false);
    return BlocProvider(
        create: (context) =>
            ProjectBloc(ProjectRepository(), storage)..add(LoadProject()),
        child: Scaffold(
            body: BlocListener<ProjectBloc, ProjectState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status &&
                    current.status == ProjectStatus.error,
                listener: (context, state) {
                  if (state.status == ProjectStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(state.message ?? 'Произошла ошибка')),
                    );
                  }
                },
                child: BlocBuilder<ProjectBloc, ProjectState>(
                    builder: (context, state) {
                  switch (state.status) {
                    case ProjectStatus.initial:
                      return const SizedBox.shrink();
                    case ProjectStatus.loading:
                      return Center(child: CircularProgressIndicator());
                    case ProjectStatus.loaded:
                      return ListView.builder(
                          itemCount: state.projects.length,
                          itemBuilder: (context, index) {
                            final project = state.projects[index];
                            return ListTile(
                              title: Text(project.shortName),
                              onLongPress: () async {
                                final shouldDelete = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Удалить проект?'),
                                    content: Text('Вы действительно хотите удалить проект "${project.shortName}"?'),
                                    actions: [
                                      TextButton(
                                        child: Text('Отмена'),
                                        onPressed: () => Navigator.of(context).pop(false),
                                      ),
                                      TextButton(
                                        child: Text('Удалить'),
                                        onPressed: () => Navigator.of(context).pop(true),
                                      ),
                                    ],
                                  ),
                                );
                                if (!context.mounted) return;
                                if (shouldDelete == true) {
                                  context.read<ProjectBloc>().add(DeleteProject(id: project.id));
                                }
                              },
                            );
                          });
                    case ProjectStatus.error:
                      return Center(
                        child: Text(state.message ?? "Ошибка загрузки"),
                      );
                  }
                }))));
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [_Email(), _Name(), _LogoutButton()],),);
  }
}


class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Logout'),
      onPressed: () {
        context.read<AuthenticationBloc>().add(AuthenticationLogoutPressed());
      },
    );
  }
}

class _Email extends StatelessWidget {
  const _Email();

  @override
  Widget build(BuildContext context) {
    print("${context.select(
    (AuthenticationBloc bloc) => bloc.state.user)}");
    final email = context.select(
      (AuthenticationBloc bloc) => bloc.state.user.email,
    );

    return Text('Email: ${email ?? "Нет почты"}');
  }
}

class _Name extends StatelessWidget {
  const _Name({super.key});

  @override
  Widget build(BuildContext context) {
    final name = context.select(
          (AuthenticationBloc bloc) => bloc.state.user.name,
    );
    return Text('Name: $name');
  }
}

