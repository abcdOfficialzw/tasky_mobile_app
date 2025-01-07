// task_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/local_db/sql_lite_database_helper.dart';
import '../../../local_db/task_model.dart';
import 'event.dart';
import 'state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<SearchTaskEvent>(_onSearch);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  Future<List<Task>> _fetchTasks() async {
    List<Task> tasks;
    return await SQLiteDatabaseHelper.instance.fetchAllTasks();
  }

  Future<void> _onLoadTasks(
      LoadTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await _fetchTasks();
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(error: e.toString()));
    }
  }

  Future<void> _onSearch(SearchTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks =
          await SQLiteDatabaseHelper.instance.searchTask(event.searchString);
      if (tasks.isEmpty) {
        return emit(TaskSearchNotFound());
      }
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(error: e.toString()));
    }
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    try {
      emit(TaskAdding());
      // Add the task to the database
      await SQLiteDatabaseHelper.instance
          .addTask(event.task)
          .then((value) async {
        emit(TaskAdded());
        // Load the tasks from the database
        emit(TaskLoading());
        final tasks = await _fetchTasks();
        emit(TaskLoaded(tasks: tasks));
      });
    } catch (e) {
      emit(TaskError(error: e.toString()));
    }
  }

  Future<void> _onUpdateTask(
      UpdateTaskEvent event, Emitter<TaskState> emit) async {
    try {
      emit(TaskLoading());
      // Update the task in the database
      await SQLiteDatabaseHelper.instance
          .updateTask(event.task)
          .then((value) async {
        emit(TaskUpdated());

        // Load the tasks from the database
        emit(TaskLoading());
        final tasks = await _fetchTasks();
        emit(TaskLoaded(tasks: tasks));
      });
    } catch (e) {
      emit(TaskError(error: e.toString()));
    }
  }

  Future<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    await SQLiteDatabaseHelper.instance
        .updateTask(event.task)
        .then((value) async {
      emit(TaskDeleted());
      emit(TaskLoading());
      final tasks = await _fetchTasks();
      emit(TaskLoaded(tasks: tasks));
    });
  }
}
