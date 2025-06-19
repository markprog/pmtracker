import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tasks_bloc.dart';
import '../widgets/section_and_task.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        switch (state.status) {
          case SectionsAndTasksStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case SectionsAndTasksStatus.loaded:
          // Проверяем, что проект есть и в нем есть секции
            final project = state.project;
            if (project == null || project.sections.isEmpty) {
              return const Center(child: Text('Нет секций и задач'));
            }
            return Scaffold(
              appBar: AppBar(
                title: Text(project.name), // Показываем имя проекта
              ),
              body: ListView.builder(
                itemCount: project.sections.length,
                itemBuilder: (context, index) {
                  final section = project.sections[index];
                  return CustomSection(
                    title: section.name,
                    tasks: section.tasks,
                    isExpandedNotifier: ValueNotifier(false),
                    childBottomSheet: _ToggleSection(),
                  );
                },
              ),
            );
          case SectionsAndTasksStatus.error:
            return Center(
              child: Text(
                state.message ?? 'Error uploading data',
                style: const TextStyle(color: Colors.red),
              ),
            );
          case SectionsAndTasksStatus.initial:
          default:
            return Center(child: Text("Please select a project"),);
        }
      },
    );
  }
}


// TODO: Change and add this widget to utils and make universal
class _ToggleSection extends StatefulWidget {
  const _ToggleSection({super.key});

  @override
  State<_ToggleSection> createState() => _ToggleSectionState();
}

class _ToggleSectionState extends State<_ToggleSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: const Icon(Icons.edit, color: Colors.blue),
            title: const Text(
              "Change section title",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.add_circle, color: Colors.blue),
            title: const Text(
              "Add new section",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text(
              "Delete Section",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
