part of 'tasks_bloc.dart';

enum SectionsAndTasksStatus { initial, loading, loaded, empty, error }

class TasksState extends Equatable {
  final SectionsAndTasksStatus status;
  final List<Section> sectionsAndTasks;
  final String? message;

  const TasksState(
      {this.status = SectionsAndTasksStatus.initial,
      this.sectionsAndTasks = const [],
      this.message});

  TasksState copyWith({
    SectionsAndTasksStatus? status,
    List<Section>? sectionsAndTasks,
    String? message,
  }) {
    return TasksState(
      status: status ?? this.status,
      sectionsAndTasks: sectionsAndTasks ?? this.sectionsAndTasks,
      message: message ?? this.message,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, sectionsAndTasks, message];
}
