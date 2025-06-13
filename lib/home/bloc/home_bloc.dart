import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:project_repository/project_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences_repository/storage_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository repository;
  final SharedPreferencesHelper storage;

  ProjectBloc(this.repository, this.storage) : super(ProjectState()) {
    on<LoadProject>(_onLoadProject);
    on<DeleteProject>(_onDeleteProject);
  }

  Future<void> _onLoadProject(
      LoadProject event, Emitter<ProjectState> emit) async {
    emit(state.copyWith(status: ProjectStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      final accessToken = storage.accessToken;
      final http.Response getProjects = await repository.fetchProjects(accessToken);
      final projects = await compute(parseProjects, getProjects.body);
      emit(state.copyWith(status: ProjectStatus.loaded, projects: projects));
    } catch (e) {
      log("$e");
      emit(state.copyWith(
          status: ProjectStatus.error, message: "Error uploading project"));
    }
  }

  Future<void> _onDeleteProject(
      DeleteProject event, Emitter<ProjectState> emit) async {
    emit(state.copyWith(status: ProjectStatus.loading));
    try {
      final accessToken = storage.accessToken;
      await repository.deleteProject(accessToken, event.id);
      final List<Project> updated = List<Project>.from(state.projects)
        ..removeWhere((p) => p.id == event.id);
      emit(state.copyWith(projects: updated, status: ProjectStatus.loaded));
    } catch (e) {
      emit(
        state.copyWith(
            status: ProjectStatus.error, message: "Error deleting project"),
      );
    }
  }

  // Future<void> _onCreateProject(CreateProject event, Emitter<ProjectState> emit) async {
  //   if (state is ProjectLoaded) {
  //     final current = List<Project>.from((state as ProjectLoaded).projects);
  //     emit(ProjectLoading());
  //     try {
  //     } catch (e) {
  //
  //     }
  //   }
  // }
}

List<Project> parseProjects(String body) {
  final Map<String, dynamic> decoded = jsonDecode(body);
  final List<dynamic> projectList = decoded['data']['projects'];
  return projectList.map((json) => Project.fromJson(json)).toList();
}
