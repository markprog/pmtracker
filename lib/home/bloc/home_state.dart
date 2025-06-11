
part of 'home_bloc.dart';
// abstract class ProjectState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }
//
// final class ProjectInitial extends ProjectState {}
//
// final class ProjectLoading extends ProjectState {}
//
// final class ProjectLoaded extends ProjectState {
//   final List<Project> projects;
//   ProjectLoaded(this.projects);
//
//   @override
//   List<Object?> get props => [projects];
// }
//
// final class ProjectError extends ProjectState {
//   final String message;
//
//   ProjectError(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
enum ProjectStatus { initial, loading, loaded, error }


class ProjectState extends Equatable {
  final ProjectStatus status;
  final List<Project> projects;
  final String? message;

  const ProjectState({this.status = ProjectStatus.initial, this.projects = const [], this.message});

  ProjectState copyWith({
    ProjectStatus? status,
    List<Project>? projects,
    String? message,
}) {
    return ProjectState(status: status ?? this.status,
    projects: projects ?? this.projects,
    message: message ?? this.message
    );
  }

  @override
  List<Object?> get props => [status, projects, message];
}