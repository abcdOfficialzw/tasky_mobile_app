import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:tasky/app/tasks/views/pages/add_tasks_page.dart';

import '../../../../../local_db/task_model.dart';

class TasksView extends StatelessWidget {
  final List<Task> tasks;
  final Future<void> Function() onRefresh;
  final Function(Task task) onDelete;
  final Function(Task task) onEdit;

  const TasksView({
    super.key,
    required this.tasks,
    required this.onRefresh,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    enableDrag: true,
                    isDismissible: true,
                    builder: (context) {
                      return AddTasksPage(
                        onSendTask: onEdit,
                        task: tasks[index],
                      );
                    });
              },
              leading: Icon(
                tasks[index].isSynced
                    ? Icons.cloud_done_outlined
                    : Icons.cloud_off_rounded,
                color: tasks[index].isSynced
                    ? Colors.green
                    : Theme.of(context).colorScheme.primaryContainer,
              ),
              isThreeLine: false,
              title: Text(tasks[index].title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(tasks[index].description),
                  Text(
                    "DUE: ${tasks[index].deadline.day}  ${DateFormat.MMMM().format(tasks[index].deadline)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: tasks[index].deadline.isBefore(DateTime.now())
                          ? Colors.red
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              trailing: GestureDetector(
                onTap: () {
                  onDelete(tasks[index]);
                },
                child: Icon(
                  tasks[index].deleted
                      ? Icons.delete_forever
                      : Icons.delete_outline,
                  color: Colors.red.withOpacity(0.5),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
