import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matrix_app_w_bloc/navigation/cubit/home_nav_bar_cubit.dart';
import 'package:matrix_app_w_bloc/tasks/bloc/tasks_bloc.dart';
import 'package:project_repository/project_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences_repository/storage_repository.dart';
import 'package:tasks_repository/tasks_repository.dart';

import '../../authentication/bloc/authentication_bloc.dart';
import '../../constants/AppIcons.dart';
import '../../utils.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              // TODO: Add localization
              child: Text(
                "Projects",
                // AppLocalizations.of(context)!.hmAppProjects,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          ],
          title: Row(
            children: [
              SvgPicture.asset(
                AppIcons.gallery,
                width: 30,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'MATRIX',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
        body: _ProjectsBody());
  }
}

class _ProjectsBody extends StatelessWidget {
  const _ProjectsBody();

  Future<void> _onRefresh(BuildContext context) async {
    context.read<ProjectBloc>().add(LoadProject());
    await Future.delayed(Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectBloc, ProjectState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == ProjectStatus.error,
      listener: (context, state) {
        if (state.status == ProjectStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? 'Произошла ошибка')),
          );
        }
      },
      child: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          switch (state.status) {
            case ProjectStatus.initial:
              return const SizedBox.shrink();
            case ProjectStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case ProjectStatus.loaded:
              return RefreshIndicator(
                  child: _ProjectList(projects: state.projects),
                  onRefresh: () => _onRefresh(context));
            case ProjectStatus.error:
              return Center(
                child: Text(state.message ?? "Ошибка загрузки"),
              );
          }
        },
      ),
    );
  }
}

class _ProjectList extends StatelessWidget {
  const _ProjectList({required this.projects});
  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return _CardWidget(text: project.shortName, projectId: project.id);
      },
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({super.key, required this.text, required this.projectId});
  final String text;
  final int projectId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        // NOTE: Use this for navigate from this screen to tasks screen and sections of this project
        onTap: () async {
          context.read<HomeNavBarCubit>().changeTo(1);
          context.read<TasksBloc>().add(ProjectChanged(projectId));
        },
        onLongPress: () {
          log("Long press on project");
          Utils.showModalBottom(context: context, child: _ToggleProject());
        },
        leading: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        title: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing:
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      ),
    );
  }
}

class _ToggleProject extends StatelessWidget {
  const _ToggleProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title: const Text(
              "Delete Section",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onTap: () {
              print("Delete project");
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_Email(), _Name(), _LogoutButton()],
      ),
    );
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
    print("${context.select((AuthenticationBloc bloc) => bloc.state.user)}");
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
