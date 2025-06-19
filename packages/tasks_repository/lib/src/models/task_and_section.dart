class FullProject {
  final String name;
  final List<Section> sections;

  FullProject({
    required this.name,
    required this.sections,
  });

  factory FullProject.fromJson(Map<String, dynamic> json) {
    return FullProject(
      name: json['name'],
      sections: (json['sections'] as List)
          .map((section) => Section.fromJson(section))
          .toList(),
    );
  }
}

class Section {
  final int id;
  final String name;
  final List<Task> tasks;

  Section({
    required this.id,
    required this.name,
    required this.tasks,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      name: json['name'],
      tasks: (json['tasks'] as List)
          .map((task) => Task.fromJson(task))
          .toList(),
    );
  }
}

class Task {
  final int id;
  final int is_finished;
  final String name;
  // Добавь другие поля при необходимости

  Task({
    required this.id,
    required this.name,
    required this.is_finished,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      is_finished: json['is_finished'],
    );
  }
}