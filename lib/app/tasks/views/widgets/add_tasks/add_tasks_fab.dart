import 'package:flutter/material.dart';
import 'package:tasky/app/tasks/views/pages/add_tasks_page.dart';

import '../../../../../local_db/task_model.dart';

class AddTasksFAB extends StatelessWidget {
  final Function(Task task) onSendTask;
  final bool isLoading;
  const AddTasksFAB({
    super.key,
    required this.onSendTask,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            enableDrag: true,
            isDismissible: true,
            builder: (BuildContext context) {
              return AddTasksPage(
                onSendTask: (task) {
                  onSendTask(task);
                  Navigator.pop(context);
                },
              );
            });
      },
      child: const Icon(Icons.add_task_rounded),
    );
  }
}
