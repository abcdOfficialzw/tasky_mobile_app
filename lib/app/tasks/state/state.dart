// task_state.dart
import 'package:equatable/equatable.dart';
import 'package:tasky/local_db/task_model.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskAdding extends TaskState {}

class TaskAdded extends TaskState {}

class TaskSearchNotFound extends TaskState {}

class TaskUpdated extends TaskState {}

class TaskDeleted extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}

class TaskError extends TaskState {
  final String error;

  const TaskError({required this.error});

  @override
  List<Object?> get props => [error];
}
