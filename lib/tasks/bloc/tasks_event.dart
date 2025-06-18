part of 'tasks_bloc.dart';

sealed class TasksEvent {}

class ProjectChanged extends TasksEvent {
  final int projectId;
  ProjectChanged(this.projectId);
}
