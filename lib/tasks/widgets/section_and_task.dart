import 'package:flutter/material.dart';
import 'package:tasks_repository/tasks_repository.dart';

import '../../constants/AppColors.dart';
import '../../utils.dart';

class CustomSection extends StatelessWidget {
  final String title;
  final List<Task> tasks;
  final ValueNotifier<bool> isExpandedNotifier;
  final Widget childBottomSheet;

  const CustomSection({
    super.key,
    required this.title,
    required this.tasks,
    required this.isExpandedNotifier,
    required this.childBottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
      child: ValueListenableBuilder<bool>(
        valueListenable: isExpandedNotifier,
        builder: (context, isExpanded, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  isExpandedNotifier.value = !isExpanded;
                },
                child: Row(
                  children: [
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(Icons.arrow_drop_down, size: 24),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Utils.showModalBottom(context: context, child: childBottomSheet),
                      icon: const Icon(
                        Icons.more_horiz,
                        color: AppColor.darkBlue,
                      ),
                    )
                  ],
                ),
              ),
              if (isExpanded)
                SizedBox(
                  height: tasks.length * 70,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return ListTile(
                        onTap: () {
                          print('Tapped on task: ${task.name}');
                        },
                        leading: const Icon(Icons.check_circle_outline, color: Colors.green),
                        title: Text(
                            task.name,
                            style: Theme.of(context).textTheme.titleMedium
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}