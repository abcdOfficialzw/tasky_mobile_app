import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/app/tasks/state/bloc.dart';
import 'package:tasky/app/tasks/state/event.dart';
import 'package:tasky/app/tasks/state/state.dart';
import 'package:tasky/app/tasks/views/widgets/add_tasks/add_tasks_fab.dart';
import 'package:tasky/app/tasks/views/widgets/task_search_not_found_widget.dart';

import '../../../../local_db/task_model.dart';
import '../../../../services/secure_storage.dart';
import '../../../../sync_service/models/repo/impl/sync_repository_impl.dart';
import '../../../../utils/constants/dimens.dart';
import '../widgets/tasks_empty.dart';
import '../widgets/tasks_search.dart';
import '../widgets/tasks_view/tasks_view.dart';
import 'package:logging/logging.dart';
import 'package:cron/cron.dart' as crn;

class TasksPage extends StatelessWidget {
  const TasksPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc()..add(LoadTasksEvent()),
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return SafeArea(
            child: BlocListener<TaskBloc, TaskState>(
              listener: (context, state) {
                if (state is TaskAdding) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Adding task..."),
                    ),
                  );
                } else if (state is TaskAdded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Task added!"),
                    ),
                  );
                } else if (state is TaskError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(state.error),
                    ),
                  );
                }
              },
              child: Scaffold(
                floatingActionButton: AddTasksFAB(
                  onSendTask: (task) {
                    context.read<TaskBloc>().add(AddTaskEvent(task: task));
                  },
                  isLoading: state is TaskAdding,
                ),
                body: Padding(
                  padding: EdgeInsets.all(Dimens.padding.medium),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TasksSearch(
                        onSearch: (String searchString) {
                          context.read<TaskBloc>().add(SearchTaskEvent(
                                searchString: searchString,
                              ));
                        },
                      ),
                      SizedBox(
                        height: Dimens.spacing.normal,
                      ),
                      state is TaskLoading
                          ? const Center(child: CircularProgressIndicator())
                          : state is TaskError
                              ? Text(state.error)
                              : state is TaskLoaded
                                  ? state.tasks.isEmpty
                                      ? const TasksEmpty()
                                      : TasksView(
                                          onDelete: (Task task) async {
                                            print("Id to delete: ${task.id}");
                                            Task _task =
                                                task.copy(deleted: true);
                                            context.read<TaskBloc>().add(
                                                DeleteTaskEvent(task: _task));
                                          },
                                          onEdit: (Task task) {
                                            print("Edit task: $task");
                                            context
                                                .read<TaskBloc>()
                                                .add(UpdateTaskEvent(
                                                  task: task,
                                                ));
                                            context.pop();
                                          },
                                          onRefresh: () async {
                                            context
                                                .read<TaskBloc>()
                                                .add(LoadTasksEvent());
                                          },
                                          tasks: state.tasks)
                                  : state is TaskSearchNotFound
                                      ? const TaskSearchNotFoundWidget()
                                      : const SizedBox.shrink()
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
