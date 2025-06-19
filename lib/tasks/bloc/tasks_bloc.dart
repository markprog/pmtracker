import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:project_repository/project_repository.dart';
import 'package:shared_preferences_repository/storage_repository.dart';
import 'package:tasks_repository/tasks_repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TasksRepository repository;
  final SharedPreferencesHelper storage;

  TasksBloc(this.repository, this.storage) : super(TasksState()) {
    on<ProjectChanged>(_onProjectChanged);
  }

  Future<void> _onProjectChanged(ProjectChanged event, Emitter<TasksState> emit) async {
    emit(state.copyWith(status: SectionsAndTasksStatus.loading));
    try {
      final accessToken = storage.accessToken;
      final getSectionsAndTasks = await repository.getTasksAndSections(event.projectId, accessToken);
      final sectionsAndTasks = await compute(parseSectionsAndTasks, getSectionsAndTasks.body);
      emit(state.copyWith(status: SectionsAndTasksStatus.loaded, sectionsAndTasks: sectionsAndTasks));
    } catch (e) {
      emit(state.copyWith(status: SectionsAndTasksStatus.error, message: "Error uploading sections and tasks"));
    }
  }
}

FullProject parseSectionsAndTasks(String body) {
  final Map<String, dynamic> decoded = jsonDecode(body);
  final projectList = decoded['data']['project'];
  return FullProject.fromJson(projectList);
}