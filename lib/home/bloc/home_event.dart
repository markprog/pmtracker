part of 'home_bloc.dart';


sealed class ProjectEvent{}

class LoadProject extends ProjectEvent {}

class CreateProject extends ProjectEvent{
  final String name;
  final String description;
  final String shortName;
  final String type;

  CreateProject({required this.name, required this.description, required this. shortName, required this.type});
}


class DeleteProject extends ProjectEvent {
  final int id;
  DeleteProject({required this.id});
}