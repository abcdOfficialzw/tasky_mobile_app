import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasky/app/tasks/state/bloc.dart';
import 'package:tasky/app/tasks/state/event.dart';
import 'package:tasky/app/tasks/state/state.dart';
import 'package:tasky/utils/constants/dimens.dart';

import '../../../../local_db/task_model.dart';
import '../widgets/add_tasks/deadline_picker_item.dart';
import '../widgets/add_tasks/send_new_task_button.dart';

class AddTasksPage extends StatefulWidget {
  final Function(Task task) onSendTask;
  final Task? task;

  AddTasksPage({super.key, required this.onSendTask, this.task});

  @override
  State<AddTasksPage> createState() => _AddTasksPageState();
}

class _AddTasksPageState extends State<AddTasksPage> {
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  int selectedDeadline = 0;
  DateTime? deadline;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(10000));
    if (picked != null && picked != deadline) {
      setState(() {
        deadline = picked;
        selectedDeadline = 2;
        print(deadline);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      selectedDeadline = 2;
      deadline = widget.task!.deadline;
    }
    deadline ??= DateTime.now().add(const Duration(hours: 1));

    _taskTitleController.text = widget.task?.title ?? "";
    _taskDescriptionController.text = widget.task?.description ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimens.padding.large),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            style: Theme.of(context).textTheme.titleLarge,
            controller: _taskTitleController,
            decoration: InputDecoration.collapsed(
              hintText: "e.g., Study Portugues every weekday",
              hintStyle: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.grey),
            ),
          ),
          SizedBox(
            height: Dimens.padding.medium,
          ),
          TextField(
            style: Theme.of(context).textTheme.bodyLarge!,
            controller: _taskDescriptionController,
            decoration: InputDecoration.collapsed(
              hintText: "Description",
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.grey),
            ),
          ),
          SizedBox(
            height: Dimens.spacing.medium,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                DeadlinePickerItem(
                  icon: Icons.today_rounded,
                  text: "Today",
                  selected: selectedDeadline == 0,
                  onSelect: () {
                    setState(() {
                      selectedDeadline = 0;
                      deadline = DateTime.now();
                      print(deadline);
                    });
                  },
                ),
                SizedBox(
                  width: Dimens.spacing.small,
                ),
                DeadlinePickerItem(
                  icon: Icons.next_plan_outlined,
                  text: "Tomorrow",
                  selected: selectedDeadline == 1,
                  onSelect: () {
                    setState(() {
                      selectedDeadline = 1;
                      deadline = DateTime.now().add(const Duration(days: 1));
                      print(deadline);
                    });
                  },
                ),
                SizedBox(
                  width: Dimens.spacing.small,
                ),
                DeadlinePickerItem(
                  icon: Icons.edit_calendar_rounded,
                  text: selectedDeadline == 2
                      ? "${deadline!.day}  ${DateFormat.MMMM().format(deadline!)}"
                      : "Custom",
                  selected: selectedDeadline == 2,
                  onSelect: () {
                    _selectDate(context);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: Dimens.spacing.small,
          ),
          Divider(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          SizedBox(
            height: Dimens.spacing.medium,
          ),
          SendNewTaskButton(
            onSendTask: () {
              Task task;
              if (widget.task != null) {
                task = widget.task!.copy(
                    title: _taskTitleController.text,
                    description: _taskDescriptionController.text,
                    deadline: deadline,
                    lastModified: DateTime.now());
              } else {
                task = Task(
                    title: _taskTitleController.text,
                    description: _taskDescriptionController.text,
                    deadline: deadline!,
                    lastModified: DateTime.now());
              }

              widget.onSendTask(task);
            },
          ),
        ],
      ),
    );
  }
}
