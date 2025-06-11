class Project {
  final int id;
  final String shortName;

  Project({required this.id, required this.shortName});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(id: json["id"], shortName: json["short_name"]);
  }
}
