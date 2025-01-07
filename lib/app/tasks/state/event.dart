// task_event.dart
import 'package:equatable/equatable.dart';

import '../../../local_db/task_model.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final Task task;

  const AddTaskEvent({
    required this.task,
  });

  @override
  List<Object?> get props => [
        task,
      ];
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;

  const UpdateTaskEvent({
    required this.task,
  });

  @override
  List<Object?> get props => [task];
}

class SearchTaskEvent extends TaskEvent {
  final String searchString;

  const SearchTaskEvent({
    required this.searchString,
  });

  @override
  List<Object?> get props => [searchString];
}

class DeleteTaskEvent extends TaskEvent {
  final Task task;

  const DeleteTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];
}
