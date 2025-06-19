part of 'tasks_bloc.dart';

enum SectionsAndTasksStatus { initial, loading, loaded, empty, error }

class TasksState extends Equatable {
  final SectionsAndTasksStatus status;
  final FullProject? project;
  final String? message;

  const TasksState(
      {this.status = SectionsAndTasksStatus.initial,
      this.project,
      this.message});

  TasksState copyWith({
    SectionsAndTasksStatus? status,
    FullProject? sectionsAndTasks,
    String? message,
  }) {
    return TasksState(
      status: status ?? this.status,
      project: sectionsAndTasks ?? this.project,
      message: message ?? this.message,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, project, message];
}
